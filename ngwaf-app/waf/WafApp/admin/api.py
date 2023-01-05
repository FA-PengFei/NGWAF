# Add this as a seperate port only which the docker networking can reach

import uvicorn
from fastapi import FastAPI, UploadFile, Form

app = FastAPI()

@app.post("/admin/replace_model")
async def replace_model(updated_model_file: UploadFile = Form(...)):

    #TODO: Run some checks on the file, checks its csv, correct column format etc
    # override existing file if exists
    with open(f"/waf/WafApp/saved_model/saved_model.pb", "wb") as f:
        f.write(updated_model_file.file.read())
        f.close()

    return {"message": "Model Update Successful"}


if __name__ == "__main__":
    uvicorn.run(app, host='0.0.0.0', port=8888)