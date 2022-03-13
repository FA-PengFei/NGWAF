FROM ubuntu:20.04

RUN apt update -y && apt upgrade -y
RUN apt install -y python3 python3-pip

WORKDIR /waf

COPY ./run.sh /waf/run.sh
RUN chmod +x /waf/run.sh

COPY ./requirements.txt /waf/requirements.txt
RUN pip3 install -r /waf/requirements.txt

# Pre Download NLTK Data
RUN python3 -c 'import nltk; nltk.download("all")'

# Easier Debugging
# COPY ./WafApp/ /waf/

# Need this to show all logs somehow
# https://stackoverflow.com/questions/60773195/docker-compose-flask-app-not-printing-output-from-print
ENV PYTHONUNBUFFERED=1

ENTRYPOINT ["bash", "run.sh"]