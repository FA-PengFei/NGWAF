import os
# botocore version must be right or s3 download cannot work
os.system('pip install botocore==1.26.4')

import argparse
import datetime

import re
import random
import string
import numpy as np
import pandas as pd

import tensorflow as tf
from tensorflow.keras import layers

from sklearn.feature_extraction.text import CountVectorizer
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score,roc_auc_score

import joblib
from urllib.parse import unquote


def split_sentence(sentence):
    # No underscore
    out = re.split(r"[,.$'\"<>\+\-\*\=\{\}\(\)\[\]\~/\\\#\%\:\;\?\!\@\s]", sentence)
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
    X_train = np.array([[string] for string in X_clean])  # each string needs to be in its own list
    y_train = np.array(dataset[y_col])

    return X_train, y_train


class DatasetGenerator(tf.keras.utils.Sequence):
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
def build_model_architecture(vocab):
    b_model = tf.keras.models.Sequential()
    b_model.add(tf.keras.Input(shape=(1,), dtype=tf.string))  # one string input per batch
    b_model.add(layers.TextVectorization(
        max_tokens=None,
        split="whitespace",
        output_mode="count",  # 'multi_hot' if just want count
        vocabulary=vocab,  # list of vocab words we wanna keep
    ))
    b_model.add(layers.Dense(256, activation='relu'))
    b_model.add(layers.Dense(1024, activation='relu'))
    b_model.add(layers.BatchNormalization())
    b_model.add(layers.Dropout(0.5))
    b_model.add(layers.Dense(1, activation='sigmoid'))

    b_model.compile(
        loss='binary_crossentropy',
        optimizer='adam', 
        metrics=[tf.keras.metrics.Recall(), 'accuracy']
    )

    return b_model


# Model evaluation
def performance(model, X_test, y_test, logs, mode='sklearn_model'):
    if mode == 'sklearn_model':
        yscore = model.predict_proba(X_test)[:,1]
        ypred = model.predict(X_test)
    elif mode == 'tf':
        yhat = model.predict(X_test)
        yscore = yhat.flatten()
        ypred = np.rint(yscore)
    elif mode == 'tf_generator':
        yhat = model.predict(X_test)  # tensorflow 1: predict_generator
        yscore = yhat.flatten()
        ypred = np.rint(yscore)
    else:
        raise ValueError("`mode` not recognized")

    y_test = np.array(y_test).astype('float32')

    print_log(logs, f"Average malicious label in test (truth) = {np.mean(y_test)}")
    print_log(logs, f"Average malicious label in PREDICTIONS = {np.mean(ypred)}")

    # Format is (y_true, y_score/y_pred)
    print_log(logs, "Accuracy of model: %.3f "% accuracy_score(y_test, ypred))
    print_log(logs, "F1_score of model: %.3f "% f1_score(y_test, ypred))
    print_log(logs, "auc_roc of model: %.3f "% roc_auc_score(y_test, yscore)) # needs scores not 0/1
    print_log(logs, "recall of model: %.3f "% recall_score(y_test, ypred))


def print_log(logs, text):
    logs.append(str(datetime.datetime.now()) + "\t" + text)
    print(text)


if __name__ == "__main__":

    parser = argparse.ArgumentParser()

    parser.add_argument('--epochs', type=int, default=10)
    parser.add_argument('--learning-rate', type=float, default=0.01)
    parser.add_argument('--batch-size', type=int, default=128)
    parser.add_argument('--gpu-count', type=int, default=0)
    parser.add_argument('--model-dir', type=str, default='/tmp')
    parser.add_argument('--bucket', type=str, default=None)
    parser.add_argument('--train', type=str, default=os.environ.get('SM_CHANNEL_TRAINING'))
    parser.add_argument('--test', type=str, default=os.environ.get('SM_CHANNEL_TEST'))
    parser.add_argument("--sm_model_dir", type=str, default=os.environ.get("SM_MODEL_DIR"))
    parser.add_argument("--pretrained", type=int, default=0)

    args, _ = parser.parse_known_args()

    # Start logging
    logs = []

    # Download the dataset
    train = pd.read_csv(os.path.join(args.train, "training.csv"))
    val = pd.read_csv(os.path.join(args.train, "validation.csv"))
    test = pd.read_csv(os.path.join(args.train, "testing.csv"))
    print_log(logs, f"Train set = {len(train)}")
    print_log(logs, f"Val set = {len(val)}")
    print_log(logs, f"Test set = {len(test)}")

    # Prepare generators
    gen_train = DatasetGenerator(train, args.batch_size)
    gen_val = DatasetGenerator(val, args.batch_size)
    gen_test = DatasetGenerator(test, args.batch_size)

    # Load pretrained model
    if (args.pretrained == 1):
        new_model = tf.keras.models.load_model(os.path.join(args.train, "pretrained_keras"))
        # Freeze training for the text vectorization layers, which is the first
        for idx, l in enumerate(new_model.layers):
            if idx in [0]:
                l.trainable = False
            else:
                l.trainable = True
        print_log(logs, "Loaded pretrained model, froze first layer for text vectorization")
    # If not, build model architecture from scratch
    else:
        vectorizer = generate_count_vectorizer(train)
        vocab = list(vectorizer.vocabulary_.keys())
        new_model = build_model_architecture(vocab)
        print_log(logs, f"Build new model with vocabulary length {len(vocab)}")

    if args.gpu_count > 1:
        new_model = tf.keras.utils.multi_gpu_model(new_model, gpus=args.gpu_count)

    new_model.compile(
        loss='binary_crossentropy',
        optimizer='adam',
        metrics=[tf.keras.metrics.Recall(), 'accuracy']
    )
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
    training_logs = new_model.fit(
        gen_train,
        epochs=args.epochs,
        callbacks=[early_stop],
        verbose=True,
        validation_data=gen_val,
    )

    # Check performance on test set
    performance(new_model, gen_test, test['label'], logs, mode='tf_generator')

    # Save model for deploying
    out_path = os.path.join(args.sm_model_dir, "0001")
    tf.saved_model.save(new_model, out_path)
    print_log(logs, f"Saved to {out_path}")
    
    # Save keras version for retraining
    keras_path = os.path.join(args.sm_model_dir, "keras")
    tf.keras.models.save_model(new_model, keras_path)
    print_log(logs, f"Saved keras version to {keras_path}")
                               
    # Save logs
    log_path = os.path.join(args.sm_model_dir, "logs.txt")
    log_file = open(log_path, "w")
    log_file.write("\n".join(logs))
    log_file.close()
    print(f"Written logs to {log_path}")


