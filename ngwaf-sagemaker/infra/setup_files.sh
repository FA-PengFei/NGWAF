#!/bin/bash

set -ex

sudo -u ec2-user -i <<'EOF'
DOWNLOAD_FILE_SCRIPT="/tmp/setup_files.py"
/bin/cat <<EOM >$DOWNLOAD_FILE_SCRIPT
import boto3; 
import os.path

ssm_client=boto3.client('ssm');
s3_client=boto3.client('s3');

ngwaf_notebook_script_bucket_name = ssm_client.get_parameter(Name='ngwaf_notebook_script_bucket_name', WithDecryption=False)['Parameter']['Value']

def download_file(bucket_name, bucket_key, filepath):
    # Only download if file does not exist
    if not os.path.exists(filepath):
        with open(filepath, 'wb') as data:
            s3_client.download_fileobj(bucket_name, bucket_key, data)

download_file(ngwaf_notebook_script_bucket_name, 'train.ipynb', '/home/ec2-user/SageMaker/ngwaf-sagemaker/train.ipynb')
download_file(ngwaf_notebook_script_bucket_name, 'model_v2.py', '/home/ec2-user/SageMaker/ngwaf-sagemaker/script/model_v2.py')
download_file(ngwaf_notebook_script_bucket_name, 'utils_v1.py', '/home/ec2-user/SageMaker/ngwaf-sagemaker/script/utils_v1.py')
download_file(ngwaf_notebook_script_bucket_name, 'boto3_utils.py', '/home/ec2-user/SageMaker/ngwaf-sagemaker/boto3_utils.py')
download_file(ngwaf_notebook_script_bucket_name, 'diagnostic_utils.py', '/home/ec2-user/SageMaker/ngwaf-sagemaker/diagnostic_utils.py')

EOM

if /usr/bin/python -c "import boto3" 2>/dev/null; then
    PYTHON_DIR='/usr/bin/python'
elif /usr/bin/python3 -c "import boto3" 2>/dev/null; then
    PYTHON_DIR='/usr/bin/python3'
else
    # If no boto3 just quit because the script won't work
    echo "No boto3 found in Python or Python3. Exiting..."
    exit 1
fi

mkdir -p /home/ec2-user/SageMaker/ngwaf-sagemaker/script
$PYTHON_DIR /tmp/setup_files.py

EOF