# Docker multi stage build to build frontend
FROM node:12-alpine
RUN apk -U update

WORKDIR /app
COPY frontend/admin-portal/ .

RUN yarn install
RUN yarn build

# FROM python:3.10.0-buster --> somehow having issues installing pandas and numpy
FROM ubuntu:20.04

RUN apt update && apt upgrade -y
RUN apt install -y python3 python3-pip
WORKDIR /app/backend

# Container Setup
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Pre Download NLTK Data
RUN python3 -c 'import nltk; nltk.download("all")'

# Copy to requirements later
# RUN pip3 install gensim
# RUN pip3 install fastapi[all] python-multipart

# Try and follow juypter notebook file structure
COPY data/ /app/data
COPY backend /app/backend

RUN mkdir /app/model

# Transfer Frontend stuff over
COPY --from=0 /app/build ./webapp

CMD [ "python3", "api.py" ]