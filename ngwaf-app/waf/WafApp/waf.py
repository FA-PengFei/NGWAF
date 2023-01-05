import requests

import uvicorn
from fastapi import FastAPI

from starlette.routing import Route
from starlette.responses import Response, HTMLResponse

import classifier as mlwaf

import cache_helper
import decode_helper
import json
import log_helper

import telegram_bot

async def proxy(starlette_request):
    # Check of /magic is up
    if not decode_helper.is_decoder_alive():
        return HTMLResponse("System is booting. Please Wait.")

    return await request_handler(starlette_request)

# Not supporting other less common HTTP methods such as TRACE due to security reasons
routes = [
    Route("/", endpoint=proxy, methods=['GET', 'POST', 'PUT', 'PATCH','DELETE','HEAD', 'OPTIONS']),
    Route("/{path:path}", endpoint=proxy, methods=['GET', 'POST', 'PUT', 'PATCH','DELETE','HEAD', 'OPTIONS']),
]

# Blocks the Docs Page
app = FastAPI(openapi_url=None, routes=routes)

def unpack_payload(payload, unpack_counter=1):
    # TODO: Prevent Memory from overloading, Throw an Custom Exception
    # if unpack_counter > 50:
    #     return None
    # print(type(payload))

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

async def inspect_request(request):
    payload_check = []
    # Add in URL path for checking
    payload_check.append(request.url.path)

    # Check thru GET Params
    for key in request.query_params.keys():
        payload_check.append(key)
        payload_check = payload_check + unpack_payload(request.query_params[key])

    # Check thru JSON
    # Handle JSON Parsing Error
    try:
        json_data = await request.json()
    except json.decoder.JSONDecodeError:
        json_data = None

    if json_data:
        for key in json_data:
            payload_check.append(key)
            payload_check = payload_check + unpack_payload(json_data[key])

    # Check thru Form Data
    form_data = await request.form()
    if form_data:
        for key in form_data:
            payload_check.append(key)
            payload_check = payload_check + unpack_payload(form_data[key])

    #TODO: Causes false positivies for now
    for header in request.headers.keys():
        value = request.headers[header]
        payload_check.append(header)
        payload_check.append(value)

    for cookie_name in request.cookies.keys():
        value = request.cookies.get(cookie_name)
        payload_check.append(cookie_name)
        payload_check.append(value)

    #TODO: Check through plain data? - would form and json capture all? or can just use this?
    # payload_check.append(await request.body()) # Produces bytes, safe to convert to string?

    print("[ * ] Printing Payload(s)")
    i = 0
    k = 0
    for payload in payload_check:
        i += 1
        print("Payload {} = ".format(i), payload)

    #TODO: Not sure if we should only inspect decoded text or both
    # Perform Decoding of Payload if possible
    payload_check = decode_helper.decode_payloads(payload_check)

    if len(payload_check) > 0:
        score, payload = mlwaf.prediction(payload_check)
        log_msg = {}
        log_msg["URL"] = request.url.path
        log_msg["Payload"] = payload
        log_msg["Label"] = score
        log_helper.log_data(json.dumps(log_msg))
        
        threshold = float(cache_helper.fetch_config("ml_threshold"))

        if score >= threshold:
            telegram_bot.send_telegram_notification(payload)

        return score >= threshold

async def handle_redirect(request, target_server):
    if request.url.scheme == "https":
        url = f"https://{target_server}{request.url.path}"
    elif request.url.scheme == "http":
        url = f"http://{target_server}{request.url.path}"
    else:
        return Response(f"Unsupport Scheme: {request.url.scheme}", status_code=500)

    print("SENT TO HONEYPOT " + url)
    # new_request = request
    send_headers = {}
    for header in request.headers.keys():
        value = request.headers[header]
        send_headers[header] = value

    get_param = {}
    for param in request.query_params.keys():
        get_param[param] = request.query_params[param]

    # Handle JSON Parsing Error
    try:
        json_body = await request.json()
    except json.decoder.JSONDecodeError:
        json_body = None

    form_body = await request.form()

    resp = requests.request(
        method=request.method, url=url, verify=False,
        json=json_body, headers=send_headers, params=get_param,
        data=form_body,
        allow_redirects=False
    )

    send_content = resp.content

    #TODO: Dropping headers due to proxy setting - need to double check
    excluded_headers = ['content-encoding', 'content-length', 'transfer-encoding', 'connection']

    resp_headers = {}
    for item in resp.raw.headers.items():
        name , value = item
        if name.lower() not in excluded_headers:
            resp_headers[name] = value

    response = Response("", status_code=403) if send_content is None else Response(send_content, resp.status_code, headers=resp_headers)
    return response
    
async def request_handler(starlette_request):
    honeypot_mode = cache_helper.fetch_config("honeypot_mode").decode("utf-8")
    if honeypot_mode == "duplicate":
        honey_pot_server = cache_helper.fetch_config("duplicate_endpoint").decode("utf-8")
    elif honeypot_mode == "custom":
        honey_pot_server = "custom-honey:8000"
    else:
        honey_pot_server = "drupot:5000"

    # Check if client is blocked
    src_ip = starlette_request.client.host
    print(f"src_ip: {src_ip}")
    is_client_blocked = cache_helper.is_client_blocked(src_ip)

    if(is_client_blocked):
        print(f"IP is blocked...")
        return await handle_redirect(starlette_request, honey_pot_server)
    
    # Pass thru Detector - Need to improve the speed
    is_blocked = await inspect_request(starlette_request)

    # Request got Blocked, redirect to Honey Pot
    if is_blocked:
        # Store in Cache
        cache_helper.block_client(src_ip)

        # Need to handle this http and https dynamically
        return await handle_redirect(starlette_request, honey_pot_server)
    else:
        dest_server = cache_helper.fetch_config("protected_endpoint").decode("utf-8")
        return await handle_redirect(starlette_request, dest_server)

if __name__ == '__main__':
    uvicorn.run(app, host='0.0.0.0', port=80)
