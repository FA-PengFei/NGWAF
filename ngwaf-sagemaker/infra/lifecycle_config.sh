#!/bin/bash

set -ex

# Set Python Environment
if /usr/bin/python -c "import boto3" 2>/dev/null; then
    PYTHON_DIR='/usr/bin/python'
elif /usr/bin/python3 -c "import boto3" 2>/dev/null; then
    PYTHON_DIR='/usr/bin/python3'
else
    # If no boto3 just quit because the script won't work
    echo "No boto3 found in Python or Python3. Exiting..."
    exit 1
fi

# Create Script to Stop Notebook
# Taken from https://github.com/aws-samples/amazon-sagemaker-notebook-instance-lifecycle-config-samples
STOP_NOTEBOOK_SCRIPT="/tmp/stop_notebook.py"
/bin/cat <<EOM >$STOP_NOTEBOOK_SCRIPT
# NOTEBOOK_NAME=$(cat /opt/ml/metadata/resource-metadata.json  | jq -r '.ResourceName');
import boto3; 
import json;
client=boto3.client('sagemaker');
ssm_client = boto3.client('ssm');

def get_notebook_name():
    log_path = '/opt/ml/metadata/resource-metadata.json'
    with open(log_path, 'r') as logs:
        _logs = json.load(logs)
    return _logs['ResourceName']

ssm_client.put_parameter(Name='ngwaf_should_notebook_start', Value='TRUE', Overwrite=True)
client.stop_notebook_instance(NotebookInstanceName=get_notebook_name())
EOM

SHOULD_START=$(python3 -c 'import os; import boto3; ssm_client = boto3.client("ssm"); print(ssm_client.get_parameter(Name="ngwaf_should_notebook_start", WithDecryption=False)["Parameter"]["Value"])')

if [ $SHOULD_START == "FALSE" ]; then
    # Do this as notebook state might not be ready state to stop
    # Check Every Minute and stop notebook if idle for 1 minute only on notebook creation
    (crontab -l 2>/dev/null; echo "*/1 * * * * $PYTHON_DIR /tmp/stop_notebook.py") | crontab -
else
    sudo -u ec2-user -i <<'EOF'
    # PARAMETERS
    ENVIRONMENT=python3
    NOTEBOOK_FILE="/home/ec2-user/SageMaker/ngwaf-sagemaker/train.ipynb"

    # Starting the instance and notebook
    echo "Activating conda env"
    source /home/ec2-user/anaconda3/bin/activate "$ENVIRONMENT"

    ## TODO: Check that the tmp dirs are empty
    rm -rf /home/ec2-user/SageMaker/ngwaf-sagemaker/_tmp

    echo "Starting notebook"
    nohup jupyter nbconvert  --to notebook --inplace --ExecutePreprocessor.timeout=3600 --ExecutePreprocessor.kernel_name=python3 --execute "$NOTEBOOK_FILE" &
    # timeout = cell execution timeout. can set to None or -1 to remove restriction
    # kernel = execution kernel. can remove and it will use the default from notebook metadata
    echo "Deactivating conda env"
    source /home/ec2-user/anaconda3/bin/deactivate
EOF
fi