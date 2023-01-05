import boto3
import json
import re
from urllib.parse import urlparse, parse_qs

# Endpoint name
# ENDPOINT_NAME = "ngwaf-test-v2"
ssm_client = boto3.client('ssm')
ENDPOINT_NAME = ssm_client.get_parameter(Name='ngwaf_endpoint_name', WithDecryption=False)['Parameter']['Value']

# Processing 
hygiene = lambda x: [i for i in x if i not in ["", " "]]
unroll = lambda x: [item for items in x for item in items]

def prepare_tokens(sentence):
  output = re.split('([^a-zA-Z0-9\_(\-\-)(\=\=)])', sentence)
  output = hygiene(output)
  output = unroll([hygiene(re.split('(\-\-)', i)) for i in output])
  output = unroll([hygiene(re.split('(\=\=)', i)) for i in output])
  # Convert to lower
  output = [s.lower() for s in output]
  return output

def process_url(url, debug=False):
  parsed_url = urlparse(url)
  # For the path, just get the words out
  path_items = hygiene(re.split('[^a-zA-Z0-9\_]', parsed_url.path))
  # For the query, split into key and value, then further split
  query = parse_qs(parsed_url.query)
  query_items = []
  if debug:
    print("Path =", parsed_url.path)
    print("Query = ", query)
  for k, v in query.items():
    query_items.extend(prepare_tokens(k))
    for vv in v:
      query_items.extend(prepare_tokens(vv))

  return path_items + query_items

def lambda_handler(event, context):


    sentence = json.loads(event['body'])
    sentence = sentence['payload']
    sentence = " ".join(process_url(sentence))

    runtime = boto3.Session().client('sagemaker-runtime')
    response = runtime.invoke_endpoint(EndpointName=ENDPOINT_NAME,
                                       ContentType='application/json',
                                       Body=json.dumps([sentence]))  # should be list[Str] with one item only   

    predictions = response['Body'].read().decode('utf-8')
    predictions = json.loads(predictions)
    score = predictions['predictions'][0][0]
    print(score)

    return {
        'statusCode' : 200,
        'headers' : {'Content-Type' : 'application/json', 'Access-Control-Allow-Origin' : '*' },
        'body' : json.dumps({"score": score})
    }
