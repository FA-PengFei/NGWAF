import boto3
import os

# dev = boto3.session.Session(profile_name='aws_iam_stf_call_amplify')
dev = boto3.Session(
    aws_access_key_id=os.environ['ACCESS_KEY_ID'],
    aws_secret_access_key=os.environ['SECRET_ACCESS_KEY']
)

S3_BUCKET=os.environ['BUCKET_NAME']

def fetch_s3_file_stats(s3_obj):
    num_rows = 0
    file_size = 0

    s3_client = dev.client('s3')

    sql_stmt = """SELECT count(*) FROM s3object S"""  
    resp =s3_client.select_object_content(
        Bucket=S3_BUCKET,
        Key=s3_obj,
        ExpressionType='SQL',
        Expression=sql_stmt,
        InputSerialization={'CSV': {"FileHeaderInfo": "Use", "AllowQuotedRecordDelimiter": True}},
        OutputSerialization={'CSV': {}},
    )

    for event in resp['Payload']:
        if 'Records' in event:
            rr=event['Records']['Payload'].decode('utf-8')
            arr = rr.split("\n")
            num_rows = int(arr[0].strip())

    obj_stats = s3_client.head_object(Bucket=S3_BUCKET, Key=s3_obj)
    file_size = obj_stats["ContentLength"]

    return file_size, num_rows
    

def list_files():
    files = []
    s3 = dev.resource('s3')
    bucket = s3.Bucket(S3_BUCKET)
    for obj in bucket.objects.all():
        file_size, num_rows = fetch_s3_file_stats(obj.key)
        files.append({
            "fileName": obj.key,
            "fileSize": str(round((file_size / 1000), 2)),
            "numRows": num_rows
            })
    return files

def upload_file(file, file_name):
    # f = open('data.csv', 'rb')

    s3 = dev.resource('s3')
    bucket = s3.Bucket(S3_BUCKET)
    obj = bucket.Object(file_name)
    obj.upload_fileobj(file)

    # s3 = dev.client('s3')
    # s3.upload_file('data.csv','ngwaf-trainbucket', 'somekey1')

def download_file(filename):
    pass

def delete_file(filename):
    s3 = dev.resource('s3')
    bucket = s3.Bucket(S3_BUCKET)
    obj = bucket.Object(filename)
    obj.delete()