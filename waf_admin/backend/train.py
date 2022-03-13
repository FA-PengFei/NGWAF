#!/usr/bin/env python
# coding: utf-8

#import libraries
import numpy as np
import pandas as pd

from nltk.corpus import stopwords
stopwords = set(stopwords.words('english'))

from sklearn.pipeline import Pipeline
from sklearn.linear_model import LogisticRegression 
from sklearn.tree import DecisionTreeClassifier
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.model_selection import GridSearchCV

import re
import joblib


from os import listdir

def clean(text):
    pattern = re.compile(r"\d*([^\d\W]+)\d*") # removes only those numbers appearing with words but leaves individual numbers alone
    return pattern.sub(r"\1", text)

def train_model(default_dataset_df, custom_dataset_df, output_dir):
    # # load default datasets
    # df = pd.read_csv('../data/training.csv',index_col=0)
    # xss= pd.read_csv('../data/XSS_dataset.csv', index_col =0)
    # df2 = pd.concat([df, xss])

    df2= pd.concat([default_dataset_df,custom_dataset_df])

    vectorizer = CountVectorizer( min_df=2, max_df=0.7, stop_words=stopwords,token_pattern ='[a-zA-Z0-9$&+,:;=?@#|<>.^*()%!-]+')
    X = vectorizer.fit_transform(df2['Sentence'].apply(lambda x:clean(x)))
    y = df2['Label']

    from sklearn.base import BaseEstimator
    class DummyEstimator(BaseEstimator):
        def fit(self): pass
        def score(self): pass
            
    # Create a pipeline
    pipe = Pipeline([('m', DummyEstimator())]) 

    # Create param grid.
    param_grid = [
            {
        'm': [LogisticRegression()],
        'm__penalty' : ['l1', 'l2'],
        'm__C' : np.logspace(-4, 4, 20),
        'm__solver' : ['liblinear']},
        {
            'm' : [DecisionTreeClassifier()],
            'm__max_depth' : list(range(2,10)),
            'm__min_samples_leaf': [5, 10, 20, 50, 100],
            'm__criterion': ["gini", "entropy"]
        }
            ]

    # Create grid search object
    clf = GridSearchCV(pipe, param_grid = param_grid, cv = 10, verbose=True, n_jobs=2)
    clf.fit(X,y)

    model = clf.best_estimator_
    # save the model to disk
    filename = f"{output_dir}/saved_model.pb"
    joblib.dump(model, open(filename, 'wb'))
