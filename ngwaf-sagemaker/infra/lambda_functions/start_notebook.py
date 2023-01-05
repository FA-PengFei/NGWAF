import json
import boto3

# NOTEBOOK_NAME = "ngwaf-test-v3"
ssm_client = boto3.client('ssm')
NOTEBOOK_NAME = ssm_client.get_parameter(Name='ngwaf_notebook_name', WithDecryption=False)['Parameter']['Value']

# Trigger notebook
def lambda_handler(event, context):
    
    sm = boto3.client("sagemaker")
    sm.start_notebook_instance(NotebookInstanceName=NOTEBOOK_NAME)
    print(f"Notebook {NOTEBOOK_NAME} started")

    return {
        'statusCode': 200,
        'headers': {'Content-Type' : 'application/json', 'Access-Control-Allow-Origin' : '*' },
        'body': event # dictionary with keys `message` and `job_key`
    }
