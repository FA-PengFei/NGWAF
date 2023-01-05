FROM ubuntu:20.04

RUN apt update -y && apt upgrade -y
RUN apt install -y python3 python3-pip

WORKDIR /waf
RUN mkdir -p /waf/logs/

COPY ./WafApp/ /waf/WafApp
COPY ./run.sh /waf/run.sh
COPY ./requirements.txt /waf/requirements.txt

RUN useradd -ms /bin/bash wafuser
RUN chown -R wafuser:wafuser /waf/
RUN chmod -R u+wxr /waf/
USER wafuser

RUN chmod +x /waf/run.sh
RUN pip3 install -r /waf/requirements.txt

# Need this to show all logs
# https://stackoverflow.com/questions/60773195/docker-compose-flask-app-not-printing-output-from-print
ENV PYTHONUNBUFFERED=1

CMD ["bash", "run.sh"]