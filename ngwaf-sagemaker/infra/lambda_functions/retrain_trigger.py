import boto3
import time
import json

# Resource names here
# DYNAMO_TABLE_NAME = "ngwaf-training-pipeline"
# BUCKET_NAME = "ngwaf-sagemaker"
# STATE_MACHINE_ARN = "arn:aws:states:ap-southeast-1:000394774158:stateMachine:NGWAF-Notebook-Monitoring"

ssm_client = boto3.client('ssm')
DYNAMO_TABLE_NAME = ssm_client.get_parameter(Name='ngwaf_dynamodb_table_name', WithDecryption=False)['Parameter']['Value']
BUCKET_NAME = ssm_client.get_parameter(Name='ngwaf_bucket_name', WithDecryption=False)['Parameter']['Value']
STATE_MACHINE_ARN = ssm_client.get_parameter(Name='ngwaf_state_machine_arn', WithDecryption=False)['Parameter']['Value']


def lambda_handler(event, context):
    db = boto3.client("dynamodb")
    s3 = boto3.client("s3")

    # Check pipeline status
    pipeline_available = db.get_item(
        TableName=DYNAMO_TABLE_NAME,
        Key={"job_key": {"S": "_pipeline_status"}}
    )["Item"]["pipeline_available"]["BOOL"]

    if not pipeline_available:
        return {
            "statusCode": 400,
            'headers' : {'Content-Type' : 'application/json', 'Access-Control-Allow-Origin' : '*' },
            'body' : json.dumps({"message": "job currently in progress already!"})
        }

    # If pipeline available, retrieve training file name
    training_file = json.loads(event['body'])['train_file_path'] # use this when deploying to API gateway
    # training_file = event['body']['train_file_path'] # use this for lambda testing

    new_key = "job-" + time.strftime("%Y-%m-%d-%H-%M-%S", time.gmtime())
    print("New job key =", new_key)

    # Move dataset. will rewrite any existing files
    s3.copy_object(
        CopySource=training_file,
        Bucket=BUCKET_NAME,
        Key="_tmp_train/data.csv"
    )
    print(f"Copied file from {training_file} to {BUCKET_NAME}/_tmp_train/data.csv")

    # Add new job
    db.put_item(
        TableName=DYNAMO_TABLE_NAME,
        Item={
            "job_key": {"S": new_key},
            "status": {"S": "training"}
        }
    )
    print("Added new job to dynamoDB")

    # Update status to busy
    db.update_item(
        TableName=DYNAMO_TABLE_NAME,
        Key={"job_key": {"S": "_pipeline_status"}},
        AttributeUpdates={
            "pipeline_available": {"Value": {"BOOL": False}, "Action": "PUT"},
            "pipeline_job_key": {"Value": {"S": new_key}, "Action": "PUT"}
        }
    )
    print("Updated pipeline status to busy")

    output = {
        "message": "training has kicked off",
        "job_key": new_key
    }

    # Start state machine for sagemaker
    sfn = boto3.client("stepfunctions")
    sfn.start_execution(
        input=json.dumps(output),
        stateMachineArn=STATE_MACHINE_ARN
    )
    print("Step function called to start notebook")

    return {
        "statusCode": 200,
        'headers': {'Content-Type' : 'application/json', 'Access-Control-Allow-Origin' : '*' },
        'body': json.dumps(output)
    }