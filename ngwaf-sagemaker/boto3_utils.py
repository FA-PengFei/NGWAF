import os
import boto3

def write_df_to_s3(df, local_name, bucket, key):
    # Start client
    s3 = boto3.client("s3")
    
    # Need to save locally
    local_path = os.path.join("_tmp", local_name)
    df.to_csv(local_path, index=False)
    print(f"Saved locally to _tmp/{local_name}")
    
    # Then upload to s3
    s3.upload_file(local_path, Bucket=bucket, Key=key)
    print(f"Uploaded to s3://{bucket}/{key}")
    
def get_config_name(ENDPOINT_NAME):
    sm_client = boto3.client("sagemaker")
    endpoint_config_name = sm_client.describe_endpoint(EndpointName=ENDPOINT_NAME)["EndpointConfigName"]
    return endpoint_config_name

def get_model_variant(ENDPOINT_NAME):
    sm_client = boto3.client("sagemaker")
    endpoint_config_name = get_config_name(ENDPOINT_NAME)
    details = sm_client.describe_endpoint_config(EndpointConfigName=endpoint_config_name)
    variants = details['ProductionVariants']
    model_names = [item['ModelName'] for item in variants]
    return model_names