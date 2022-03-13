import redis
from datetime import timedelta

# Maybe use another db for caching pages to speed up ciphey later on
client = redis.Redis(host='cache', port=6379, db=0)

decode_client = redis.Redis(host='cache', port=6379, db=1)

def block_client(src_ip):
    client.setex(src_ip, timedelta(minutes=1), "true")

def is_client_blocked(src_ip):
    return client.get(src_ip) != None

# Used for storing decodings
def fetch_decode(payload):
    return decode_client.get(payload)

def store_decode(payload, decoded_payload):
    decode_client.setex(payload, timedelta(minutes=30) ,decoded_payload)

# Used for storing common pages
def store_content(url):
    return None

def fetch_content(url):
    pass