import json
import boto3
from boto3.dynamodb.conditions import Key, Attr

# DYNAMO_TABLE_NAME = "ngwaf-training-pipeline"
ssm_client = boto3.client('ssm')
DYNAMO_TABLE_NAME = ssm_client.get_parameter(Name='ngwaf_dynamodb_table_name', WithDecryption=False)['Parameter']['Value']

def lambda_handler(event, context):

    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(DYNAMO_TABLE_NAME)
    
    # Scan through table and get all items
    response = table.scan()
    items = response['Items']
    while 'LastEvaluatedKey' in response:
        print(response['LastEvaluatedKey'])
        response = table.scan(ExclusiveStartKey=response['LastEvaluatedKey'])
        items.extend(response['Items'])
    
    # Process item
    IGNORE_JOB_KEYS = ['_pipeline_status'] # don't return these
    items = [process_item(i) for i in items if i['job_key'] not in IGNORE_JOB_KEYS]
    
    return {
        'statusCode': 200,
        'body': json.dumps(items)
    }
    

def process_item(db_item):
    output_dict = {}
    
    # Define types
    decimal_keys = ['training_duration_sec']
    dict_decimal_keys = ['model_performance']
    dict_list_decimal_keys = ['model_diagnostics']

    for k, v in db_item.items():
        if k in decimal_keys:
            output_dict[k] = float(v)
        elif k in dict_decimal_keys:
            inner_dict = {}
            for kk, vv in db_item[k].items():
                inner_dict[kk] = float(vv)
            output_dict[k] = inner_dict
        elif k in dict_list_decimal_keys:
            inner_dict = {}
            for kk, vv in db_item[k].items():
                inner_dict[kk] = [float(i) for i in vv]
            output_dict[k] = inner_dict
        else: # regular strings
            output_dict[k] = v
    
    return output_dict
