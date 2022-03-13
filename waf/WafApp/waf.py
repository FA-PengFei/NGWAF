import requests
from flask import Flask, request, Response, abort
from werkzeug.routing import Rule

from parser import FlaskHTTPRequestParser
import classifier as mlwaf

import cache_helper
import decode_helper
import json
import log_helper


app = Flask(__name__)
app.url_map.add(Rule('/', endpoint='proxy', defaults={'path': ""}))
app.url_map.add(Rule('/<path:path>', endpoint='proxy'))

token='<ENTER YOUR OWN TELE TOKEN HERE>'
CHAT_ID = '<ENTER YOUR CHAT ID HERE>'
WAF_NAME = '<ENTER YOUR WAF NAME HERE>'
WARN_MSG = "ALERT [Security Incident] Malicious activity detected on " +WAF_NAME+ ". Please alert relevant teams and check through incident artifacts."
URL= "https://api.telegram.org/bot{}/sendMessage?chat_id={}&text={}".format(token,CHAT_ID,WARN_MSG)
PL_GLOB=""

# @app.route('/blocked', methods=['GET'])
# def show_block_page():
#     return "Blocked By Mobile Legends NGWAF :)"

@app.route('/admin/replace_model', methods=['POST'])
def replace_model():
    mlwaf.init()
    return "Model Updated!"

dest_server = "dvwa"
#dest_server = "owasp-juicebox:3000"

honey_pot_server = "drupot:5000"


def unpack_payload(payload, unpack_counter=1):
    # TODO: Prevent Memory from overloading, Throw an Custom Exception
    # if unpack_counter > 50:
    #     return None
    print(type(payload))

    if isinstance(payload, list):
        for item in payload:
            unpacked_data = unpacked_data + unpack_payload(item, unpack_counter=unpack_counter + 1)

    elif isinstance(payload, dict):
        unpacked_data = []
        for key in payload.keys():
            unpacked_data.append(key)
            unpacked_data = unpacked_data + unpack_payload(payload[key], unpack_counter=unpack_counter + 1)

    # TODO: Need to whitelist certain data types like string, number, etc
    else:
        # Convert all to string for ML Classifier
        return [str(payload)]

    return unpacked_data

def inspect_request(request):
    is_blocked = False

    payload_check = []
    # Check thru GET Params
    for key in request.args:
        payload_check.append(key)
        payload_check = payload_check + unpack_payload(request.args[key])

    # Check thru JSON
    json_data = request.get_json()
    if json_data:
        for key in json_data:
            payload_check.append(key)
            payload_check = payload_check + unpack_payload(json_data[key])


    # Check thru Form Data
    form_data = request.form
    if form_data:
        for key in form_data:
            payload_check.append(key)
            payload_check = payload_check + unpack_payload(form_data[key])

    # TODO: Handle Headers & Cookies

    print("[ * ] Printing Payload(s)")
    i = 0
    k = 0
    for payload in payload_check:
        i += 1
        print("Payload {} = ".format(i), payload)

    #TODO: Not sure if we should only inspect decoded text or both
    # Perform Decoding of Payload if possible
    payload_check = decode_helper.decode_payloads(payload_check)

    #print(payload_check)
    if len(payload_check) > 0:
        result = mlwaf.prediction(payload_check)
        for payload in payload_check:
            print("[ * ] Result for Payload '{}' = ".format(payload), result[k])

            # Logging down the result
            log_msg = {}
            log_msg["URL"] = request.path
            log_msg["Payload"] = payload
            log_msg["Label"] = result[k]
            log_helper.log_data(json.dumps(log_msg))
            
            prediction = result[k] == 1
            if prediction:
                print("[ !!!!! ] Malicious payload detected!!")
                is_blocked = True
                requests.get(url = URL)
                Pack_URL = "https://api.telegram.org/bot{}/sendMessage?chat_id={}&text=Alert Trigger: {}".format(token,CHAT_ID,payload)
                requests.get(url = Pack_URL)
                global PL_GLOB 
                PL_GLOB = payload
                break
            k += 1
            print("[ * ] This is safe!")
        return is_blocked

def handle_redirect(request, target_server):
    # Need to handle this http and https dynamically
    parser = FlaskHTTPRequestParser()
    parsed_request = parser.parse(request)

    parsed_request.host_name = target_server
    if request.is_secure:
        url = 'https://{}{}?keys={}'.format(parsed_request.host_name, parsed_request.path, PL_GLOB)
    else:
        url = 'http://{}{}?keys={}'.format(parsed_request.host_name, parsed_request.path, PL_GLOB)
    print("SENT TO HONEYPOT " + url)
    new_request = request
    send_headers = {key:value for key, value in new_request.headers}

    # Need to truncate the url from the ? - Causes error in owasp juicebox
    url = url.split("?")[0]

    resp = requests.request(
        method=parsed_request.method, url=url, verify=False,
        json=new_request.get_json(), headers=send_headers, params=new_request.args,
        data=new_request.form,
        allow_redirects=False
    )

    # Seems like no need this
    # parser = HTTPResponseParser(parsed_request)

    send_content = resp.content

    excluded_headers = ['content-encoding', 'content-length', 'transfer-encoding', 'connection']
    headers = [(name, value) for (name, value) in resp.raw.headers.items() if name.lower() not in excluded_headers]

    response = Response(status=403) if send_content is None else Response(send_content, resp.status_code, headers)

    return response
    
def request_handler():
    print("Get Request...")

    # Check if client is blocked
    src_ip = request.remote_addr
    print(f"src_ip: {src_ip}")
    is_client_blocked = cache_helper.is_client_blocked(src_ip)
    if(is_client_blocked):
        print(f"IP is blocked...")
        return handle_redirect(request, honey_pot_server)
    
    # Pass thru Detector
    is_blocked = inspect_request(request)

    # Request got Blocked, redirect to Honey Pot
    if is_blocked:
        # Store in Cache
        cache_helper.block_client(src_ip)

        # response = Response("Blocked By Mobile Legends NGWAF :)", status=302, headers={"Location": "/blocked"})

        # Need to handle this http and https dynamically
        return handle_redirect(request, honey_pot_server)

    else:
        return handle_redirect(request, dest_server)

@app.endpoint('proxy')
def proxy(path):
    return request_handler()

if __name__ == '__main__':
    # sess.init_app(app)
    # app.debug = False
    app.run(port=80, host="0.0.0.0", debug=True, threaded=True)
