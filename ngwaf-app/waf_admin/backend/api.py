import pathlib
import zipfile
from zipfile import ZipFile

import uvicorn
from fastapi import FastAPI, UploadFile, Form, Request
from fastapi.staticfiles import StaticFiles
import requests

import os
import shutil

import s3_helper
import db_helper
import cache_helper

# Serve our static web portal
from starlette.templating import Jinja2Templates
from starlette.routing import Route, Mount
from starlette.exceptions import HTTPException

templates = Jinja2Templates(directory='webapp')
async def not_found(request: Request, exc: HTTPException):
    return templates.TemplateResponse('index.html', {'request': request})

exception_handlers = {
    404: not_found
}

# # Blocks the Docs Page
app = FastAPI(openapi_url=None, exception_handlers=exception_handlers)
# app = FastAPI(openapi_url=None)


default_data_directory = "/app/data"
custom_data_directory = "/app/custom/data"
shared_waf_directory = "/waf_shared"
shared_honeypot_dir = "/custom_honey"


# Allow CORS for testing purposes
from fastapi.middleware.cors import CORSMiddleware
origins = [
    "*",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/upload_train_data")
async def upload_train_data(training_data: UploadFile = Form("training_data")):
    #TODO: Run some checks on the file, checks its csv, correct column format etc
    data_file_name = training_data.filename
    s3_helper.upload_file(training_data.file, data_file_name)

    return {"message": "Upload Successful"}

@app.post("/honey_upload")
async def upload_honeypot(honeypot: UploadFile = Form("honeypot")):
    #TODO: Run some checks on the file, checks its csv, correct column format etc no directory traversal etc

    # Store the file somewhere
    data_file_name = honeypot.filename
    data_file = honeypot.file.read()
    # override existing file if exists
    path_to_zip_file = f"{shared_honeypot_dir}/{data_file_name}"

    # Wipe the directory clean first
    for root, dirs, files in os.walk(f"{shared_honeypot_dir}/webapp/"):
        for f in files:
            os.unlink(os.path.join(root, f))
        for d in dirs:
            shutil.rmtree(os.path.join(root, d))

    with open(path_to_zip_file, "wb") as f:
        f.write(data_file)
        f.close()
    with zipfile.ZipFile(path_to_zip_file, 'r') as g:
        g.extractall(f"{shared_honeypot_dir}/webapp/")
    file_to_rem = pathlib.Path(path_to_zip_file)
    file_to_rem.unlink()
    return {"message": "Upload Successful"}

def extract_zip(input_zip):
    input_zip=ZipFile(input_zip)
    return {name: input_zip.read(name) for name in input_zip.namelist()}

@app.get("/list_train_data")
async def list_custom_train_data():
    #TODO: Maybe add other stuff here like filesize, etc
    files = []
    for file in s3_helper.list_files():
        files.append(
            {
                "fileName": file["fileName"],
                "fileSize": file["fileSize"],
                "rowNum": file["numRows"]
            }
        )

    return files

@app.post("/delete_train_data")
async def delete_custom_train_data(request: Request):
    #TODO: Do some checks
    json_req = await request.json()
    for delete_file in json_req["fileNames"]:
        try:
            s3_helper.delete_file(delete_file)
        except:
            return {"message": f"Failed to delete {delete_file}"}

    return {"message": "File deleted Successful"}

@app.post("/update_model")
async def update_model(request: Request):
    #TODO: Do some checks
    # try:
    json_req = await request.json()
    custom_files = json_req["fileNames"]

    ML_ENDPOINT = f"{os.environ['API_ENDPOINT']}/retrain"
    APIKEY = os.environ['API_KEY']
    S3BUCKET = os.environ['BUCKET_NAME']

    header = {
        "X-API-Key": APIKEY
    }

    body = {
        "train_file_path": f"{S3BUCKET}/{custom_files[0]}"
    }

    res = requests.post(ML_ENDPOINT, headers=header, json=body)

    response = res.json()
    # if "job_key" in response.keys():
        # {"message": "training has kicked off", "job_key": "job-2022-06-25-15-23-08"}
        # {"message": "job currently in progress already!"}
        # await db_helper.store_job_id(response["job_key"])

    if response["message"] == "training has kicked off":
        return {
            "message": "Training Started",
            "job_key": response["job_key"]
            }
    elif response["message"] == "job currently in progress already!":
        return {
            "message": "Training already in progress"
            }
    else:
        return {
            "message": "Unknown Error. Try again later"
            }

@app.get("/check_train_status")
async def fetch_job_status():

    ML_ENDPOINT = f"{os.environ['API_ENDPOINT']}/all-jobs"

    res = requests.get(ML_ENDPOINT)

    # job_ids = await db_helper.fetch_job_ids()
    # # job_ids = ["job-2022-06-25-15-23-08"]
    # job_status_arr = []
    # for job_id in job_ids:
    #     status = fetch_model_status(job_id)
    #     job_status_arr.append(status)

    # return {"status": job_status_arr}
    return {"status": res.json()}

@app.post("/get_config")
async def get_config(request: Request):
    json_req = await request.json()
    config_name = json_req["config_name"]

    return await db_helper.fetch_config_value(config_name)

@app.get("/get_all_config")
async def get_all_config():
    return await db_helper.fetch_all_config()

@app.post("/set_config")
async def set_config(request: Request):
    json_req = await request.json()
    config_name = json_req["config_name"]
    config_value = json_req["config_value"]

    #TODO: Add Input Validation for certain fields if need

    await db_helper.store_config_value(config_name, config_value)
    cache_helper.set_config(config_name, config_value)

    return await db_helper.fetch_config_value(config_name)

async def preload_config():
    ml_threshold = await db_helper.fetch_config_value("ml_threshold")
    if not ml_threshold:
        await db_helper.store_config_value("ml_threshold", "0.5")
        cache_helper.set_config("ml_threshold", "0.5")

    telegram_description = await db_helper.fetch_config_value("telegram_description")
    if not telegram_description:
        await db_helper.store_config_value("telegram_description", "ALERT [Security Incident] Malicious activity detected on Tester_WAF. Please alert relevant teams and check through incident artifacts.")
        cache_helper.set_config("telegram_description", "ALERT [Security Incident] Malicious activity detected on Tester_WAF. Please alert relevant teams and check through incident artifacts.")

    telegram_chat_id = await db_helper.fetch_config_value("telegram_chat_id")
    if not telegram_chat_id:
        chat_id = os.environ["TELEGRAM_CHAT_ID"]
        await db_helper.store_config_value("telegram_chat_id", chat_id)
        cache_helper.set_config("telegram_chat_id", chat_id)

    honeypot_mode = await db_helper.fetch_config_value("honeypot_mode")
    if not honeypot_mode:
        await db_helper.store_config_value("honeypot_mode", "duplicate")
        cache_helper.set_config("honeypot_mode", "duplicate")

    duplicate_endpoint = await db_helper.fetch_config_value("duplicate_endpoint")
    if not duplicate_endpoint:
        await db_helper.store_config_value("duplicate_endpoint", "vuln-lab-honey")
        cache_helper.set_config("duplicate_endpoint", "vuln-lab-honey")

    protected_endpoint = await db_helper.fetch_config_value("protected_endpoint")
    if not protected_endpoint:
        await db_helper.store_config_value("protected_endpoint", "vuln-lab")
        cache_helper.set_config("protected_endpoint", "vuln-lab")

async def load_config_into_cache():
    configs = await db_helper.fetch_all_config()
    for config_name in configs.keys():
            cache_helper.set_config(config_name, configs[config_name])

def fetch_model_status(job_id):
    ML_ENDPOINT = f"{os.environ['API_ENDPOINT']}/status"
    APIKEY = os.environ['API_KEY']

    header = {
        "X-API-Key": APIKEY
    }

    body = {
        "job_key": job_id
    }

    res = requests.post(ML_ENDPOINT, headers=header, json=body)
    return res.json()

app.mount("/", StaticFiles(directory="webapp/", html=True), name="webapp")


import time
import asyncio
if __name__ == "__main__":

    # Wait for DB to accept connections
    is_db_alive = db_helper.test_connection()
    while not is_db_alive:
        time.sleep(0.5)
        is_db_alive = db_helper.test_connection()

    # Preload Config
    asyncio.run(preload_config())
    asyncio.run(load_config_into_cache())

    uvicorn.run(app, host='0.0.0.0', port=8000)