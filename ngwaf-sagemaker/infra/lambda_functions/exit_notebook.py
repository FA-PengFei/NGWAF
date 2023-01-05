import boto3
import json

# Resource names here
# DYNAMO_TABLE_NAME = "ngwaf-training-pipeline"
# NOTEBOOK_NAME = "ngwaf-test-v3"
ssm_client = boto3.client('ssm')
DYNAMO_TABLE_NAME = ssm_client.get_parameter(Name='ngwaf_dynamodb_table_name', WithDecryption=False)['Parameter']['Value']
NOTEBOOK_NAME = ssm_client.get_parameter(Name='ngwaf_notebook_name', WithDecryption=False)['Parameter']['Value']

def check_kill_nb_status(notebook_name, sm_client):
    details = sm_client.describe_notebook_instance(NotebookInstanceName=notebook_name)
    status = details["NotebookInstanceStatus"]
    if status in ["InService"]:
        sm_client.stop_notebook_instance(NotebookInstanceName=notebook_name)
        print("Notebook was still running, was stopped")
    # Other statuses: Pending, Stopping, Stopped, Failed, Deleting, Updating
    return 0


def lambda_handler(event, context):
    db = boto3.client("dynamodb")
    sm = boto3.client("sagemaker")
    
    inputs = event["body"] # input from step function will be dictionary object
    current_job_key = inputs["job_key"]

    # Check status of current job
    current_job_details = db.get_item(
        TableName=DYNAMO_TABLE_NAME,
        Key={"job_key": {"S": current_job_key}}
    )["Item"]
    current_job_status = current_job_details["status"]["S"]

    if current_job_status == "success":
        check_kill_nb_status(NOTEBOOK_NAME, sm)
        print("Job status was success, notebook confirmed stopped")
        return {"StatusCode": 200, "Message": "Training successful completed, notebook stopped"}

    # If not success
    # 1. Update job's log status to fail
    print(f"Job still not successful.. updated {current_job_key} status to `failed`")
    db.update_item(
        TableName=DYNAMO_TABLE_NAME,
        Key={"job_key": {"S": current_job_key}},
        AttributeUpdates={
            "status": {"Value": {"S": "failed"}, "Action": "PUT"}
        }
    )

    # 2. Empty the pipeline sttaus
    db.update_item(
        TableName=DYNAMO_TABLE_NAME,
        Key={"job_key": {"S": "_pipeline_status"}},
        AttributeUpdates={
            "pipeline_available": {"Value": {"BOOL": True}, "Action": "PUT"},
            "pipeline_job_key": {"Value": {"S": ""}, "Action": "PUT"}
        }
    )

    # 3. Check and kill notebook
    check_kill_nb_status(NOTEBOOK_NAME, sm)
    print("Pipeline status changed to available, notebook stopped")

    return {
        "StatusCode": 200,
        "Message": "Training timeout, notebook stopped",
    }
