import os
# botocore version must be right or s3 download cannot work
os.system('pip install botocore==1.26.4')
os.system('HOROVOD_WITH_TENSORFLOW=1 pip install horovod[tensorflow]')

import boto3
from botocore.config import Config

import argparse
import datetime

import re
import random
import string
import numpy as np
import pandas as pd

from collections import Counter

import tensorflow as tf
from tensorflow.keras import layers

from sklearn.feature_extraction.text import CountVectorizer
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score,roc_auc_score

import joblib
from urllib.parse import urlparse, parse_qs, unquote


## Changes since v1
# 1. New function for preprocessing
# 2. New function for generating vocabulary
# 3. RNN model and retrieve the existing embeddings
# 4. New dataset class

hygiene = lambda x: [i for i in x if i not in ["", " "]]
unroll = lambda x: [item for items in x for item in items]

def prepare_tokens(sentence):
    output = re.split('([^a-zA-Z0-9\_(\-\-)(\=\=)])', sentence)
    output = hygiene(output)
    output = unroll([hygiene(re.split('(\-\-)', i)) for i in output])
    output = unroll([hygiene(re.split('(\=\=)', i)) for i in output])
    # Convert to lower
    output = [s.lower() for s in output]
    return output

def process_url(url, debug=False):
    parsed_url = urlparse(url)
    # For the path, just get the words out
    path_items = hygiene(re.split('[^a-zA-Z0-9\_]', parsed_url.path))
    # For the query, split into key and value, then further split
    query = parse_qs(parsed_url.query)
    query_items = []
    if debug:
        print("Path =", parsed_url.path)
        print("Query = ", query)
    for k, v in query.items():
        query_items.extend(prepare_tokens(k))
        for vv in v:
            query_items.extend(prepare_tokens(vv))

    return path_items + query_items


def train_val_test_split(data, train_pct, val_pct, test_pct):
    testval_frac = test_pct / (val_pct + test_pct)

    train, testval = train_test_split(data, test_size=(val_pct + test_pct), random_state=42)
    val, test = train_test_split(testval, test_size=testval_frac, random_state=42)

    return (train, val, test)


def get_vocab(train_dataset, max_df=1.0, min_df=0.0, min_count=3):
    all_tokens = [set(item) for item in train_dataset['tokens'].tolist()] # because df
    all_tokens = unroll(all_tokens)
    n_docs = len(train_dataset)
    vocab = []
    counter = Counter(all_tokens)
    print("Number of unique tokens = ", len(counter))
    for token, count in counter.items():
        freq = count / n_docs
        if (freq >= min_df) & (freq <= max_df) & (count >= min_count):
            vocab.append(token)
  
    # Should have no empty tokens
    bad_tokens = ["\x00", ""]
    for t in bad_tokens:
        if t in vocab:
            vocab.remove(t)
            print(f"Removed {t}")
  
    print("Final vocab size = ", len(vocab))
    return vocab


class DataSet(tf.keras.utils.Sequence) :
    def __init__(self, dataset, batch_size):
        self.dataset = dataset
        self.batch_size = batch_size
      
    def __len__(self):
        # Should return number of batches (ceiling) as integer
        return int(np.ceil(len(self.dataset) / float(self.batch_size)))
  
    def __getitem__(self, idx):
        start_index = idx * self.batch_size
        end_index = (idx+1) * self.batch_size
        # Required X format: tokens joined into string separated by space, and each instance is its own list
        X = np.array([[" ".join(doc)] for doc in self.dataset[start_index:end_index]['tokens'].tolist()])
        y = np.array(self.dataset[start_index:end_index]['label'].tolist())
        return X, y


# Base model architecture -- won't need to use
def build_base_model_architecture(vocab, embed_dim=64):
    rnn = tf.keras.models.Sequential()
    rnn.add(tf.keras.Input(shape=(1,), dtype=tf.string))
    rnn.add(layers.TextVectorization(
      max_tokens=None,
      split="whitespace",
      # output mode should be int
      vocabulary=vocab, # list of vocab words we wanna keep
    ))
    rnn.add(layers.Embedding(
      input_dim=len(vocab) + 2, # for "" and "[UNK]"
      output_dim=embed_dim,
      mask_zero=True #Use masking to handle the variable sequence lengths
    ))
    rnn.add(layers.Bidirectional(tf.keras.layers.LSTM(embed_dim)))
    rnn.add(layers.Dense(embed_dim, activation='relu'))
    rnn.add(layers.Dense(1, activation='sigmoid'))
    rnn.compile(loss='binary_crossentropy', 
              optimizer='adam', 
              metrics=[tf.keras.metrics.Recall(), 'accuracy'])
    return rnn

# Getting artifacts for finetuned model
def get_new_vocab_initial_embeddings(pretrained_model, new_vocab):
    # Vocab
    vocab_from_pretrained = pretrained_model.layers[0].get_vocabulary() 
    new_words = set(new_vocab) - set(vocab_from_pretrained)
    new_vocab = vocab_from_pretrained + list(new_words)
    print("Existing vocab size =", len(vocab_from_pretrained))
    print("N new vocab words = ", len(new_words))
    print("N total vocab words now =", len(new_vocab))

    # Embeddings
    embed_from_pretrained = pretrained_model.layers[1].get_weights()[0]
    print("Existing embedding dimension =", embed_from_pretrained.shape)
    embed_dim = embed_from_pretrained.shape[1]
    unseen_embeddings = np.random.uniform(size=(len(new_words), embed_dim))
    new_embeddings = np.append(embed_from_pretrained, unseen_embeddings,  axis=0)
    
    assert new_embeddings.shape[1] == embed_dim
    assert new_embeddings.shape[0] == len(new_vocab)
    print("Embedding dimension =", new_embeddings.shape)
    
    new_vocab_minus_mask = new_vocab[2:] # first item is '', second is '[UNK]'
    print("Returning vocab without masks =", len(new_vocab_minus_mask))

    return new_vocab_minus_mask, new_embeddings

# Model for finetuning
def build_finetune_model_architecture(vocab, embeddings, pretrained_model):
    rnn = tf.keras.models.Sequential()
    rnn.add(tf.keras.Input(shape=(1,), dtype=tf.string))
    rnn.add(layers.TextVectorization(
      max_tokens=None,
      split="whitespace",
      # output mode should be int
      vocabulary=vocab, # list of vocab words we wanna keep
    ))

    # Initialize embedding
    embed_dim = embeddings.shape[1]
    loaded_embed = layers.Embedding(
      input_dim=len(vocab) + 2, # for "" and "[UNK]"
      output_dim=embed_dim,
      mask_zero=True #Use masking to handle the variable sequence lengths
    )
    loaded_embed.build(input_shape=(1,))
    loaded_embed.set_weights([embeddings])
    rnn.add(loaded_embed)
    
    # Copy over LSTM layer from previous model
    rnn.add(pretrained_model.layers[2]) # rnn.add(layers.Bidirectional(tf.keras.layers.LSTM(embed_dim)))

    rnn.add(layers.Dense(embed_dim, activation='relu'))
    rnn.add(layers.Dense(1, activation='sigmoid'))
    rnn.compile(loss='binary_crossentropy', 
              optimizer='adam', 
              metrics=[tf.keras.metrics.Recall(), 'accuracy'])
    return rnn

# Model evaluation
def performance(model, X_test, y_test, logs, mode='tf_generator'):
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
    
def update_db_step_status(db_connection, status, job_key, table_name):
    db_connection.update_item(
        TableName=table_name,
        Key={"job_key": {"S": job_key}},
        AttributeUpdates={"step_status": {"Value": {"S": status}, "Action": "PUT"}}
    )
    print(f"Updated dynamo entry step_status to `{status}` for key `{job_key}`")
    

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
    parser.add_argument("--early-stop-patience", type=int, default=3)
    parser.add_argument("--region", type=str, default=os.environ.get("SM_HP_REGION"))
    parser.add_argument("--db-name", type=str, default=os.environ.get("SM_HP_DB_NAME"))
    parser.add_argument("--job-key", type=str, default=os.environ.get("SM_HP_JOB_KEY"))

    args, _ = parser.parse_known_args()
    print("current job key =", args.job_key)

    # Start logging
    logs = []
    boto_config = Config(region_name=args.region)
    db = boto3.client("dynamodb", config=boto_config)

    # Download the dataset
    train = pd.read_csv(os.path.join(args.train, "training.csv"))
    val = pd.read_csv(os.path.join(args.train, "validation.csv"))
    test = pd.read_csv(os.path.join(args.train, "testing.csv"))
    print_log(logs, f"Train set = {len(train)}")
    print_log(logs, f"Val set = {len(val)}")
    print_log(logs, f"Test set = {len(test)}")
    
    
    # Process the data
    train['tokens'] = train.apply(lambda row: process_url(row['payload']) if row['is_url'] else prepare_tokens(row['payload']), axis=1)
    val['tokens'] = val.apply(lambda row: process_url(row['payload']) if row['is_url'] else prepare_tokens(row['payload']), axis=1)
    test['tokens'] = test.apply(lambda row: process_url(row['payload']) if row['is_url'] else prepare_tokens(row['payload']), axis=1)
    update_db_step_status(db, "tf training: data processed", args.job_key, args.db_name)

    # Prepare generators
    gen_train = DataSet(train, args.batch_size)
    gen_val = DataSet(val, args.batch_size)
    gen_test = DataSet(test, args.batch_size)
    update_db_step_status(db, "tf training: generators loaded", args.job_key, args.db_name)

    # Load pretrained model
    if (args.pretrained == 1):
        pretrained_model = tf.keras.models.load_model(os.path.join(args.train, "pretrained_keras"))
        # Get updated vocab & initialized embeddings
        new_vocab = get_vocab(train, min_count=1)
        vocab, embeddings = get_new_vocab_initial_embeddings(pretrained_model, new_vocab)
        # Setup new model
        new_model = build_finetune_model_architecture(vocab, embeddings, pretrained_model)
        print_log(logs, "Loaded pretrained model, initialized with existing embeds + uniform for new words + existing LSTM weights")
        update_db_step_status(db, "tf training: pretrained model loaded", args.job_key, args.db_name)
    # If not, build model architecture from scratch
    else:
        vocab = get_vocab(train, min_count=1)
        new_model = build_base_model_architecture(vocab)
        print_log(logs, f"Build new model with vocabulary length {len(vocab)}")
        update_db_step_status(db, "tf training: new model built", args.job_key, args.db_name)

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
        patience=args.early_stop_patience,
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
    update_db_step_status(db, "tf training: model trained", args.job_key, args.db_name)

    # Check performance on test set
    performance(new_model, gen_test, test['label'], logs)

    # Save model for deploying
    out_path = os.path.join(args.sm_model_dir, "0001")
    tf.saved_model.save(new_model, out_path)
    print_log(logs, f"Saved to {out_path}")
    update_db_step_status(db, "tf training: saved deployment model", args.job_key, args.db_name)
    
    # Save keras version for retraining
    keras_path = os.path.join(args.sm_model_dir, "keras")
    tf.keras.models.save_model(new_model, keras_path)
    print_log(logs, f"Saved keras version to {keras_path}")
    update_db_step_status(db, "tf training: saved keras model", args.job_key, args.db_name)
                               
    # Save logs
    log_path = os.path.join(args.sm_model_dir, "logs.txt")
    log_file = open(log_path, "w")
    log_file.write("\n".join(logs))
    log_file.close()
    print(f"Written logs to {log_path}")
    update_db_step_status(db, "tf training: saved logs", args.job_key, args.db_name)


