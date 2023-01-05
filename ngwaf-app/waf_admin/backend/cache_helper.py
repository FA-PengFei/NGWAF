import redis

# Setting Config
waf_config_client = redis.Redis(host='cache', port=6379, db=2)

# Used for storing waf config
def fetch_config(config_name):
    return waf_config_client.get(config_name)

def set_config(config_name, config_value):
    waf_config_client.set(config_name, config_value)