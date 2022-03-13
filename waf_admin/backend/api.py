import uvicorn
from fastapi import FastAPI, File, UploadFile, Form, Request
from fastapi.staticfiles import StaticFiles
import pandas as pd
import requests

import os
import traceback

# Blocks the Docs Page
app = FastAPI(openapi_url=None)

import train as model_trainer
default_data_directory = "/app/data"
custom_data_directory = "/app/custom/data"
shared_waf_directory = "/waf_shared"


# # Allow CORS for testing purposes
# from fastapi.middleware.cors import CORSMiddleware
# origins = [
#     "*",
# ]

# app.add_middleware(
#     CORSMiddleware,
#     allow_origins=origins,
#     allow_credentials=True,
#     allow_methods=["*"],
#     allow_headers=["*"],
# )

@app.post("/upload_train_data")
async def upload_train_data(training_data: UploadFile = Form("training_data")):
    #TODO: Run some checks on the file, checks its csv, correct column format etc no directory traversal etc

    # Store the file somewhere
    data_file_name = training_data.filename
    data_file = training_data.file.read()
    # override existing file if exists

    # Check for data type
    temp_file_name = f"/tmp/{data_file_name}"
    tmp_f = open(temp_file_name, "wb")
    tmp_f.write(data_file)
    tmp_f.close()

    temp_df = pd.read_csv(temp_file_name)
    is_invalid_csv = False
    if len(temp_df.columns) != 3:
        is_invalid_csv = True
    elif "Sentence" not in temp_df.columns or "Label" not in temp_df.columns:
        is_invalid_csv = True
    os.remove(temp_file_name)

    if is_invalid_csv:
        return {"message": "Upload Failed. Invalid CSV - Check Columns"}


    with open(f"{custom_data_directory}/{data_file_name}", "wb") as f:
        f.write(data_file)
        f.close()

    return {"message": "Upload Successful"}

@app.get("/list_train_data")
async def list_custom_train_data():
    #TODO: Maybe add other stuff here like filesize, etc
    files = []
    for (dirpath, dirnames, filenames) in os.walk(custom_data_directory):
        for filename in filenames:
            data_df = pd.read_csv(f"{custom_data_directory}/{filename}")
            files.append({
                "fileName": filename, 
                "fileSize": os.path.getsize(f"{custom_data_directory}/{filename}"),
                "rowNum": len(data_df)
                })

    return files

@app.post("/delete_train_data")
async def delete_custom_train_data(request: Request):
    #TODO: Do some checks
    json_req = await request.json()
    for delete_file in json_req["fileNames"]:
        try:
            os.remove(f"{custom_data_directory}/{delete_file}")
        except:
            return {"message": f"Failed to delete {delete_file}"}

    return {"message": "File deleted Successful"}

@app.post("/update_model")
async def update_model(request: Request):
    #TODO: Do some checks
    # try:
    json_req = await request.json()
    custom_files = json_req["fileNames"]

    df = pd.read_csv(f"{default_data_directory}/training.csv",index_col=0)
    xss= pd.read_csv(f"{default_data_directory}/XSS_dataset.csv", index_col =0)
    default_df = pd.concat([df, xss])

    custom_df = pd.DataFrame()
    for data_file in custom_files:
        data_df = pd.read_csv(f"{custom_data_directory}/{data_file}", index_col=0)
        custom_df = pd.concat([custom_df, data_df])

    #TODO: Update this operation to async
    model_trainer.train_model(default_df, custom_df, output_dir=shared_waf_directory)

    combined_df = pd.concat([default_df, custom_df])
    combined_df.to_csv(f"{shared_waf_directory}/train_data.csv", index=False)
    # Send Model to WAF Server
    WAF_SERVER_URL = "http://waf:80/admin/replace_model"
    # model_file = open(saved_model_file, 'rb')
    # res = requests.post(WAF_SERVER_URL, files={'updated_model_file': model_file, 'updated_training_file': open(f"{saved_model_directory}/finalized_data.csv", "rb")})
    res = requests.post(WAF_SERVER_URL)
    print(res.text)

    # except:
    #     traceback.print_exc()
    #     return {"message": f"Failed to update Model"} 

    return {"message": "Model Update Successful"}


# Serve our static web portal
app.mount("/", StaticFiles(directory="webapp/", html=True), name="webapp")



if __name__ == "__main__":
    uvicorn.run(app, host='0.0.0.0', port=8000)