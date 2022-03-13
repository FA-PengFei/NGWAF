
import nltk
# nltk.download('all')
from nltk.corpus import stopwords
stopwords = set(stopwords.words('english'))
import numpy as np
import pandas as pd
# import tensorflow as tf
# from sklearn.model_selection import train_test_split
# from sklearn.metrics import classification_report
# from sklearn.metrics import confusion_matrix, accuracy_score, precision_score, recall_score, f1_score
from sklearn.feature_extraction.text import CountVectorizer
# from tensorflow.keras.models import Sequential, save_model, load_model
import re
import joblib

import os


# global model
# model = load_model(filepath, compile=True)
global model, df
shared_waf_directory = "/waf_shared"

def init():
    global model, df

    #read train data to initialise count vectorizer
    dfs=[]
    # filepaths = ['../data/' + f for f in listdir('../data') if f.startswith('s') ]
    train_filepath = f"{shared_waf_directory}/train_data.csv"
    model_filepath = f"{shared_waf_directory}/saved_model.pb"

    train_filepath = train_filepath if os.path.isfile(train_filepath) else "./data/training.csv"
    model_filepath = model_filepath if os.path.isfile(model_filepath) else "./saved_model/saved_model.pb"

    df = pd.read_csv(train_filepath)
    #remove nans
    df=df[~df['Sentence'].isna()]

    model = joblib.load(model_filepath)

    print("Model Loaded...")


#cleaning words
def clean(text):
    pattern = re.compile(r"\d*([^\d\W]+)\d*") # removes only those numbers appearing with words but leaves individual numbers alone
    
    return pattern.sub(r"\1", text)


def preprocess(text):
    '''
    Fits a  vectorizer on test data (pandas series) to transform it into a count vectorizer object
    '''
    vectorizer = CountVectorizer( min_df=2, max_df=0.7 ,token_pattern ='[a-zA-Z0-9$&+,:;=?@#|<>.^*()%!-]+',stop_words=stopwords)
    vectorizer.fit(df['Sentence'].apply(lambda x:clean(x)))
    X = vectorizer.transform([clean(x) for x in text])
    return X

def prediction(text):
    '''
    Utlizes the model to predict the labels 1 and 0
    '''
    y_pred = model.predict(preprocess(text))
    return np.rint(y_pred)
    # return y_pred

# print(prediction(df['Sentence'].loc[:10]),df['Sentence'].loc[:10])
init()