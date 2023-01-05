import boto3
import json

# Resource names here
# DYNAMO_TABLE_NAME = "ngwaf-training-pipeline"
ssm_client = boto3.client('ssm')
DYNAMO_TABLE_NAME = ssm_client.get_parameter(Name='ngwaf_dynamodb_table_name', WithDecryption=False)['Parameter']['Value']

def reformat_dynamo(response):
    output = {}
    for key in response["Item"]:
        if key == "model_diagnostics":
            model_diag = {}
            sub_components = response["Item"][key]["M"]
            for c in sub_components.keys():
                items = [item["N"] for item in sub_components[c]["L"]]
                model_diag[c] = items
            output["model_diagnostics"] = model_diag
        elif key == "model_performance":
            model_perf = {}
            sub_components = response["Item"][key]["M"]
            for c in sub_components.keys():
                model_perf[c] = sub_components[c]["N"]
            output["model_performance"] = model_perf
        else:
            output[key] = list(response["Item"][key].values())[0]
    return output

def lambda_handler(event, context):
    db = boto3.client("dynamodb")
    
    job_key = json.loads(event["body"])['job_key']
    #job_key = event['body']['job_key']
    
    # Check pipeline status
    try:
        response = db.get_item(
            TableName=DYNAMO_TABLE_NAME,
            Key={"job_key": {"S": job_key}}
        )
        job_info = reformat_dynamo(response)
        
        return {
            'statusCode': 200,
            'body': json.dumps(job_info)
        }
    except:
        return {"StatusCode": 400, "Message": "Key not recognized"}