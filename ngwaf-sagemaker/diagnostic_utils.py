import re
import pandas as pd
import numpy as np
from urllib.parse import urlparse, parse_qs, unquote
from sklearn.metrics import roc_auc_score

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

def get_confusion_values(df, threshold):
    FP = df[(df['label'] == 0) & (df['prediction'] >= threshold)].shape[0]
    FN = df[(df['label'] == 1) & (df['prediction'] < threshold)].shape[0]
    TP = df[(df['label'] == 1) & (df['prediction'] >= threshold)].shape[0]
    TN = df[(df['label'] == 0) & (df['prediction'] < threshold)].shape[0]
    assert (FP+FN+TP+TN) == len(df)
    return TP, TN, FP, FN

def get_statistics(df, threshold):
    def _division(num, denom):  # helper for division by 0
        return num/denom if denom else 0

    TP, TN, FP, FN = get_confusion_values(df, threshold)
    
    Precision = _division(TP, (TP+FP))
    TPR_Recall = _division(TP, (TP+FN))
    FPR_Fallout = _division(FP, (FP+TN))
    Accuracy = _division((TP+TN), (TP+TN+FP+FN))
    
    return Precision, TPR_Recall, FPR_Fallout, Accuracy

def test_diagnostics(deployed_predictor, test):
    """
    deployed_predictor should be a TensorFlowModel() class that has been deployed with .deploy()
    """
    
    # Prepare data
    test['tokens'] = test['payload'].apply(lambda x: process_url(x))
    y_test = test['label'].tolist()
    X_test = [[" ".join(row)] for row in test['tokens']]
    
    # Get predictions
    predictions = []

    # Get predictions in batches
    BATCH_SIZE = 50
    n_batches = int(np.ceil(len(test) / float(BATCH_SIZE)))

    for i in range(n_batches):
        X_batch = X_test[i*BATCH_SIZE:(i+1)*BATCH_SIZE]
        pred_batch = deployed_predictor.predict(X_batch)['predictions']
        pred_batch = [item for items in pred_batch for item in items]
        predictions.extend(pred_batch)
        
    # Make df
    data = pd.DataFrame(data = {"prediction": predictions, "label": y_test})
    
    # Get outputs
    precision_out = []
    tpr_out = []
    fpr_out = []
    acc_out = []
    thresholds = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
    for t in thresholds:
        precision, tpr, fpr, acc = get_statistics(data, t)
        precision_out.append(precision)
        tpr_out.append(tpr)
        fpr_out.append(fpr)
        acc_out.append(acc)
    
    output = pd.DataFrame(data = {"score_threshold": thresholds, 
                                  "accuracy": acc_out,
                                 "precision": precision_out,
                                 "recall": tpr_out,
                                 "false_pos_rate": fpr_out})
    output['f1_score'] = 2 * (output['precision'] * output['recall']) / (output['precision'] + output['recall'])
    output['f1_score'].fillna(0.0, inplace=True) # for division by 0
    
    return output, data

# For building dynamoDB outputs
def _num(number):
    return {"N": str(number)}

def build_dynamo_model_diagnostics(diagnostic):
    thresholds = diagnostic['score_threshold'].tolist()
    precision = diagnostic['precision'].tolist()
    recall = diagnostic['recall'].tolist()
    false_pos_rate = diagnostic['false_pos_rate'].tolist()
    accuracy = diagnostic['accuracy'].tolist()
    f1_scores = diagnostic['f1_score'].tolist()
    
    output_value = {"M": {
        "threshold": {"L": [_num(i) for i in thresholds]},  
        "precision": {"L": [_num(i) for i in precision]},
        "recall": {"L": [_num(i) for i in recall]},
        "false_pos_rate": {"L": [_num(i) for i in false_pos_rate]},
        "accuracy": {"L": [_num(i) for i in accuracy]},
        "f1_score": {"L": [_num(i) for i in f1_scores]},
    }}
    
    return output_value

def build_dynamo_model_performance(scores):
    roc_score = roc_auc_score(scores['label'], scores['prediction'])
    
    output_value = {"M": {
        "roc_auc_score": _num(roc_score)
    }}
    
    return output_value