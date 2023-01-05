import re
import random
import string
import numpy as np

from urllib.parse import unquote

from sklearn.feature_extraction.text import CountVectorizer
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score,roc_auc_score

import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras import layers


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


def prepare_count_vectorizer_input(dataset, vectorizer, x_raw_col='sentence', y_col='label', augmented=False):
    # Clean and split tokens
    X_clean = dataset[x_raw_col].apply(lambda x: unquote(x))
    X_clean = X_clean.apply(lambda x: split_sentence(x)) 
    # If augmented
    if augmented:
        X_clean = X_clean.apply(lambda x: create_augmented_sample(x))
    # Need to join into sentence separated by space
    X_clean = [" ".join(row) for row in X_clean]

    # Convert to vectorizer
    X_train = vectorizer.transform(X_clean)
    y_train = np.array(dataset[y_col])

    return X_train, y_train


class BenchmarkGenerator(tf.keras.utils.Sequence):
    def __init__(self, dataset, vectorizer, batch_size):
        self.dataset = dataset
        self.vectorizer = vectorizer
        self.batch_size = batch_size

    def __len__(self):
        # Should return number of batches (ceiling) as integer
        return int(np.ceil(len(self.dataset) / float(self.batch_size)))

    def __getitem__(self, idx):
        start_index = idx * self.batch_size
        end_index = (idx+1) * self.batch_size
        X, y = prepare_count_vectorizer_input(self.dataset[start_index:end_index], self.vectorizer)
        return X, y


# Augmentation
SPECIAL_CHARS = r",.$'\"<>\+\-\_\*\=\{\}\(\)\[\]\~/\\\#\%\:\;\?\!\@ "
def create_augmented_sample(tokens, keywords, jitter_rate=0.2):
    def jitter_token(token, jitter_rate):
        chars = []
        for c in token:
            do_jitter = np.random.uniform() <= jitter_rate
            if do_jitter:
                if c in SPECIAL_CHARS:
                    chars.append(c)
                elif c.isnumeric():
                    random_int = random.choice('0123456789')
                    chars.append(random_int)
                else:
                    chars.append(random.choice(string.ascii_lowercase))
            else:
                chars.append(c)
        return "".join(chars)

    new_tokens = []
    for t in tokens:
        if t in keywords:
            new_tokens.append(t)
        else:
            new_tokens.append(jitter_token(t, jitter_rate))

    assert len(new_tokens) == len(tokens)
    return new_tokens


class AugmentedBenchmarkGenerator(tf.keras.utils.Sequence):
    def __init__(self, dataset, vectorizer, batch_size):
        self.dataset = dataset
        self.vectorizer = vectorizer
        self.batch_size = batch_size

    def __len__(self):
        # Should return number of batches (ceiling) as integer
        return int(np.ceil(len(self.dataset) / float(self.batch_size / 2)))

    def __getitem__(self, idx):
        start_index = idx * int(self.batch_size/2)
        end_index = (idx+1) * int(self.batch_size/2)
        X, y = prepare_count_vectorizer_input(self.dataset[start_index:end_index], self.vectorizer)
        Xa, ya = prepare_count_vectorizer_input(self.dataset[start_index:end_index], self.vectorizer, augmented=True)

        Xout = np.concatenate([X.toarray(), Xa.toarray()], axis=0)
        yout = np.concatenate([y,ya])
        return Xout, yout


# Model architecture
def build_architecture_v1(count_vectorizer):
    input_dim = len(count_vectorizer.get_feature_names())  # Number of features
    print(f"Input dim = {input_dim}")

    b_model = Sequential()
    b_model.add(layers.Dense(256, input_dim=input_dim, activation='relu'))
    # b_model.add(layers.Dense(10,  activation='tanh'))
    # b_model.add(layers.Dense(256, activation='relu'))
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
