# Docker multi stage build to build frontend
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt install -y curl
RUN curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh && bash /tmp/nodesource_setup.sh
RUN apt install -y nodejs
WORKDIR /app
COPY frontend/admin-portal/ .

RUN npm install --legacy-peer-deps
# RUN npm install
RUN npm run build

# FROM python:3.10.0-buster --> somehow having issues installing pandas and numpy
FROM ubuntu:20.04
ARG RUN DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && apt install -y python3.9 python3-pip 

# Needed for Mysql
RUN apt update && apt install -y python3.9-dev libmysqlclient-dev

RUN useradd -ms /bin/bash wafuser
USER wafuser

WORKDIR /app/backend

# Container Setup
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# # Try and follow juypter notebook file structure
COPY backend /app/backend

# Transfer Frontend stuff over
COPY --from=0 /app/build ./webapp

CMD [ "python3", "api.py" ]