import requests
import os
import cache_helper

import urllib.parse
# Setup
token = os.environ['TELEGRAM_TOKEN']
# CHAT_ID = os.environ['TELEGRAM_CHAT_ID']

# WAF_NAME = 'Tester_WAF'
# WARN_MSG = "ALERT [Security Incident] Malicious activity detected on " +WAF_NAME+ ". Please alert relevant teams and check through incident artifacts."
# URL= "https://api.telegram.org/bot{}/sendMessage?chat_id={}&text={}".format(token,CHAT_ID,WARN_MSG)
# PL_GLOB=""

def send_telegram_notification(message):
    CHAT_ID = cache_helper.fetch_config("telegram_chat_id").decode("utf-8")
    # requests.get(url = URL)
    template_message = cache_helper.fetch_config("telegram_description")
    url_encoded_template_message = urllib.parse.quote_plus(template_message)
    url_encoded_message = urllib.parse.quote_plus("Detected Payload: " + message)
    Pack_URL = f"https://api.telegram.org/bot{token}/sendMessage?chat_id={CHAT_ID}&text={url_encoded_template_message}"
    requests.get(url = Pack_URL)
    Pack_URL2 = f"https://api.telegram.org/bot{token}/sendMessage?chat_id={CHAT_ID}&text={url_encoded_message}"
    requests.get(url = Pack_URL2)
    # global PL_GLOB 
    # PL_GLOB = payload