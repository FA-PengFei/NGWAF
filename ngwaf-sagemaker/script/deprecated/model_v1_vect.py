# This file will be the thing that's run inside the Sagemaker notebook
import os
os.system('pip install botocore==1.26.4')

import argparse
import tensorflow as tf
import pandas as pd

import re
import random
import string
import numpy as np

from sklearn.feature_extraction.text import CountVectorizer
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score,roc_auc_score

from tensorflow.keras import layers

# Install required packages
# os.system('pip install joblib')

import joblib
from urllib.parse import unquote

# Split into tokens using special chars. Convert to lower
def split_sentence(sentence):
    out = re.split(r"[,.$'\"<>\+\-\_\*\=\{\}\(\)\[\]\~/\\\#\%\:\;\?\!\@\s]", sentence)
    out = [x.lower() for x in out if x != ""]
    return out


def train_val_test_split(data, train_pct, val_pct, test_pct):
    testval_frac = test_pct / (val_pct + test_pct)

    train, testval = train_test_split(data, test_size=(val_pct + test_pct), random_state=42)
    val, test = train_test_split(testval, test_size=testval_frac, random_state=42)

    return (train, val, test)


def generate_count_vectorizer(train_set, x_raw_col='sentence'):
    # Clean and split tokens
    X_clean = train_set[x_raw_col].apply(lambda x: unquote(x))
    X_clean = X_clean.apply(lambda x: split_sentence(x)) 
    # Need to join into sentence separated by space
    X_clean = [" ".join(row) for row in X_clean]

    vectorizer = CountVectorizer(
        min_df=5,
        max_df=1.0,
        stop_words=None,
        token_pattern ='[a-zA-Z0-9$&+,:;=?@#|<>.^*()%!-]+'
    )

    # Fit on training data
    vectorizer.fit(X_clean)

    return vectorizer

def prepare_input(dataset, x_raw_col='sentence', y_col='label'):
    # Clean and split tokens
    X_clean = dataset[x_raw_col].apply(lambda x: unquote(x))
    X_clean = X_clean.apply(lambda x: split_sentence(x)) 
    # Need to join into sentence separated by space
    X_clean = [" ".join(row) for row in X_clean]
    X_train = np.array([[string] for string in X_clean]) # each string needs to be in its own list
    y_train = np.array(dataset[y_col])

    return X_train, y_train


class GeneratorForVect(tf.keras.utils.Sequence) :
    def __init__(self, dataset, batch_size):
        self.dataset = dataset
        self.batch_size = batch_size
      
    def __len__(self):
        # Should return number of batches (ceiling) as integer
        return int(np.ceil(len(self.dataset) / float(self.batch_size)))
  
    def __getitem__(self, idx):
        start_index = idx * self.batch_size
        end_index = (idx+1) * self.batch_size
        X, y = prepare_input(self.dataset[start_index:end_index])
        return X, y


# Model architecture
def build_vectorizer_model(vocab):
    b_model = tf.keras.models.Sequential()
    b_model.add(tf.keras.Input(shape=(1,), dtype=tf.string)) # one string input per batch
    b_model.add(layers.TextVectorization(
        max_tokens=None,
        split="whitespace",
        output_mode="count", # 'multi_hot' if just want count
        vocabulary=vocab, # list of vocab words we wanna keep
    ))
    b_model.add(layers.Dense(256, activation='relu'))
    b_model.add(layers.Dense(1024, activation='relu'))
  
    b_model.add(layers.BatchNormalization())
    b_model.add(layers.Dropout(0.5))
    b_model.add(layers.Dense(1, activation='sigmoid'))
    b_model.compile(loss='binary_crossentropy', 
                  optimizer='adam', 
                  metrics=[tf.keras.metrics.Recall(), 'accuracy'])
    
    return b_model


# Model evaluation
def performance(model, X_test, y_test, mode='sklearn_model'):
    if mode == 'sklearn_model':
        yscore = model.predict_proba(X_test)[:,1]
        ypred = model.predict(X_test)
    elif mode == 'tf':
        yhat = model.predict(X_test)
        yscore = yhat.flatten()
        ypred = np.rint(yscore)
    elif mode == 'tf_generator':
        yhat = model.predict_generator(X_test)
        yscore = yhat.flatten()
        ypred = np.rint(yscore)
    else:
        raise ValueError("`mode` not recognized")

    y_test = np.array(y_test).astype('float32')

    print(f"Average malicious label in test (truth) = {np.mean(y_test)}")
    print(f"Average malicious label in PREDICTIONS = {np.mean(ypred)}")

    # Format is (y_true, y_score/y_pred)
    print("Accuracy of model: %.3f "% accuracy_score(y_test, ypred))
    print("F1_score of model: %.3f "% f1_score(y_test, ypred))
    print("auc_roc of model: %.3f "% roc_auc_score(y_test, yscore)) # needs scores not 0/1
    print("recall of model: %.3f "% recall_score(y_test, ypred))


if __name__ == "__main__":

    parser = argparse.ArgumentParser()

    parser.add_argument('--epochs', type=int, default=10)
    parser.add_argument('--learning-rate', type=float, default=0.01)
    parser.add_argument('--batch-size', type=int, default=128)
    parser.add_argument('--gpu-count', type=int, default=0)
    parser.add_argument('--model-dir', type=str, default='/tmp')
    parser.add_argument('--data', type=str, default='data')
    parser.add_argument('--weights', type=str, default='weights')
    parser.add_argument('--vectorizer', type=str, default='vectorizer')
    parser.add_argument('--bucket', type=str, default=None)
    
    # Special
    parser.add_argument('--train', type=str, default=os.environ.get('SM_CHANNEL_TRAINING'))
    parser.add_argument('--test', type=str, default=os.environ.get('SM_CHANNEL_TEST'))
    
    parser.add_argument("--sm_model_dir", type=str, default=os.environ.get("SM_MODEL_DIR"))
    
    args, _ = parser.parse_known_args()
 
    epochs = args.epochs
    lr = args.learning_rate
    batch_size = args.batch_size
    gpu_count = args.gpu_count
    model_dir = args.model_dir
    data_path = args.data
    weights_path = args.weights
    vectorizer_path = args.vectorizer
    bucket = args.bucket

    # Download the dataset
    data = pd.read_csv(os.path.join(args.train, args.data))
    train, val, test = train_val_test_split(data, 0.6, 0.2, 0.2)
    print(f"Train set = {len(train)}")
    print(f"Val set = {len(val)}")
    print(f"Test set = {len(test)}")
                         
    # Prepare generators
    vectorizer = joblib.load(os.path.join(args.train, args.vectorizer))
    gen_train = GeneratorForVect(train, batch_size)
    gen_val = GeneratorForVect(val, batch_size)
    gen_test = GeneratorForVect(test, batch_size)

    # Prepare model
#     pretrained_model = build_architecture_v1(vectorizer)
#     pretrained_model.load_weights(os.path.join(args.train, args.weights))

#     new_model = tf.keras.models.Sequential()
#     new_model.add(pretrained_model)
    new_model = build_vectorizer_model(list(vectorizer.vocabulary_.keys()))

    if gpu_count > 1:
        new_model = tf.keras.utils.multi_gpu_model(new_model, gpus=gpu_count)

    new_model.compile(
        loss='binary_crossentropy',
        optimizer='adam',
        metrics=[tf.keras.metrics.Recall(), 'accuracy'])
    print(new_model.summary())

    # Train model
    early_stop = tf.keras.callbacks.EarlyStopping(
        monitor='val_loss',
        min_delta=0,
        patience=3,
        verbose=0,
        mode='auto',
        baseline=None,
        restore_best_weights=True  # default is False
    )
    logs = new_model.fit(
        gen_train,
        epochs=epochs,
        callbacks=[early_stop],
        verbose=True,
        validation_data=gen_val,
    )

    # Check performance on test set
    performance(new_model, gen_test, test['label'], mode='tf_generator')
    
    # Save model
    tf.saved_model.save(new_model, os.path.join(args.sm_model_dir, "0001"))
    print(f"Saved to {os.path.join(args.sm_model_dir, '0001')}")