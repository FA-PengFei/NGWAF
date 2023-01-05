FROM ubuntu:20.04
ARG RUN DEBIAN_FRONTEND=noninteractive
EXPOSE 8000
RUN apt update && apt upgrade -y && apt install -y python3.9 python3-pip

RUN mkdir -p /custom_honey/webapp/
RUN mkdir -p /honey_store/

RUN useradd -ms /bin/bash wafuser
RUN chown -R wafuser:wafuser /custom_honey/
RUN chown -R wafuser:wafuser /honey_store/

RUN chmod -R u+wxr /custom_honey/
RUN chmod -R u+wxr /honey_store/

COPY run.sh ./run.sh
RUN chmod +x run.sh

USER wafuser
WORKDIR /app
COPY ./ .

RUN pip3 install -r requirement.txt
ENV PYTHONUNBUFFERED=1

CMD ["bash", "run.sh"]