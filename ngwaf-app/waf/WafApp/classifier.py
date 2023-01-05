import pandas as pd
import os
import requests

# For Debugging
from os.path import exists
import pandas as pd

import re

# global model
# model = load_model(filepath, compile=True)
global model, df
shared_waf_directory = "/waf_shared"

def train_model(s3_data_file):
    ENDPOINT = os.environ['API_ENDPOINT']
    APIKEY = os.environ['API_KEY']

    header = {
        "X-API-Key": APIKEY
    }

    #TODO: Check for File Path
    body = {
        "train_file_path": s3_data_file
    }

    res = requests.post(f"{ENDPOINT}/retrain", headers=header, json=body)

def prediction(payload_arr):
    #TODO: Remove this after model is fixed
    payload_string = ""
    for payload in payload_arr:
        payload_string += payload.strip() + " "
    payload_string = payload_string.strip()

    ENDPOINT = os.environ['API_ENDPOINT']
    APIKEY = os.environ['API_KEY']

    header = {
        "X-API-Key": APIKEY
    }

    body = {
        "payload": payload_string
    }


    # /prediction-base: v1 (Demo as part of Feature walkthrough)
    # /prediction-demo-v1 : v2 (Demo lack of LIKE Payload Detection - retrain feature)
    # /prediction-demo-v2: v3 (Used for SQLMap Demo)
    # /prediction: (Trained from v3 model, all current retrains target this endpoint only)
    res = requests.post(f"{ENDPOINT}/prediction", headers=header, json=body)
    print(res.text)
    score = res.json()["score"]

    # #TODO: Remove when done
    stats_df = pd.DataFrame()
    if exists("/waf/WafApp/payload_records.csv"):
        stats_df = pd.read_csv("/waf/WafApp/payload_records.csv")

    stats_df = stats_df.append({"Payload": payload_string, "Score": score, "isMalicious": False, "Request Context": ""}, ignore_index=True)
    stats_df.to_csv("/waf/WafApp/payload_records.csv", index=False)

    return score, payload_string
