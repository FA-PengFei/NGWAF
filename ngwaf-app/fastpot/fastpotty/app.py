import uvicorn as uvicorn
import json
from fastapi import FastAPI, Request
from fastapi.responses import RedirectResponse
from fastapi.staticfiles import StaticFiles
from starlette.routing import Match
from loguru import logger

import os
import shutil

# Serve our static web portal
from starlette.templating import Jinja2Templates
from starlette.routing import Route, Mount
from starlette.exceptions import HTTPException

templates = Jinja2Templates(directory='webapp')
async def not_found(request: Request, exc: HTTPException):
    return RedirectResponse("/index.html")

exception_handlers = {
    404: not_found
}

app = FastAPI(openapi_url=None, exception_handlers=exception_handlers)
shared_honeypot_dir = "/custom_honey"
shared_storage_dir = "/honey_store"
# Might have some static file caching issue
app.mount("/", StaticFiles(directory=f"{shared_honeypot_dir}/webapp", html=True, check_dir=False), name="webapp")

@app.middleware("http")
async def log_middle(request: Request, call_next):

    # Copy Default Honeypot if folder is empty
    if os.path.isdir(f"{shared_honeypot_dir}/webapp") and len(os.listdir(f"{shared_honeypot_dir}/webapp")) == 0:
        os.rmdir(f"{shared_honeypot_dir}/webapp")
        shutil.copytree("/app/webapp", f"{shared_honeypot_dir}/webapp")

    routes = request.app.router.routes
    send_param = None
    for route in routes:
        match, scope = route.matches(request)
        if match == Match.FULL:
            send_param = list(scope["path_params"].items())

    send_head = request.headers.items()
    send_body = (await request.body()).decode("utf-8")
    packed_boi = {"method":request.method,"url":str(request.url),"param":send_param,"headers":send_head,"body":send_body}
    packed_json = json.dumps(packed_boi)

    with open(f"{shared_storage_dir}/fastpotlogs.json", 'a+') as outfile:
        outfile.write("\n")
        outfile.write(packed_json)

    response = await call_next(request)
    return response

if __name__ == "__main__":
    uvicorn.run(app, host='0.0.0.0', port=8000)

