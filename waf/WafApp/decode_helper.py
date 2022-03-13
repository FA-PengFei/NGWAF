# from ciphey import decrypt
# from ciphey.iface import Config

import cache_helper
import requests

# import signal

# Give 10 seconds
DECODE_TIME_LIMIT = 10

def decode_payloads(payloads):
    decode_payload_list = []

    for payload in payloads:
        decode_payload_list.append(decode_payload(payload))

    # print(f"Original Payload:")
    # for payload in payloads:
    #     print(payload)

    # print(f"New Payload:")
    # for payload in decode_payload_list:
    #     print(payload)

    return decode_payload_list

def handler(signum, frame):
    raise Exception("Decode Time Limit")

def decode_payload(payload):

    # Check for empty string
    if len(payload) == 0:
        return payload

    # Checks if cache has the decoded content
    decoding = cache_helper.fetch_decode(payload)

    if decoding != None:
        # Refresh the cache expiry timer
        cache_helper.store_decode(payload, decoding)
        return decoding.decode()

    decode_text = None
    res = requests.post("http://decode:3000/magic", json={"input": payload})
    # We will take the first answer (assume its the best match)

    decode_text = res.json()["value"][0]["data"]
    print(f"Decoded Text: {decode_text}")


    # try:
    #     # Add time limit for decoding - only works in linux
    #     signal.signal(signal.SIGALRM, handler)
    #     signal.alarm(DECODE_TIME_LIMIT)
    #     decode_text = decrypt(
    #         Config().library_default().complete_config(),
    #         payload,
    #     )
    # except Exception:
    #     # Return orignal text if failed to decode
    #     decode_text = payload

    cache_helper.store_decode(payload, decode_text)
    return decode_text
