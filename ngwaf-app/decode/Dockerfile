FROM node:alpine3.10

WORKDIR /cyberchef_app

LABEL author "Wes Lambert, wlambertts@gmail.com"
LABEL description="Dockerised version of Cyberchef server (https://github.com/gchq/CyberChef-server)"
LABEL copyright "Crown Copyright 2020"
LABEL license "Apache-2.0"
COPY ./ ./
RUN npm cache clean --force && npm install
ENTRYPOINT ["npm", "--prefix", "/cyberchef_app", "run", "prod"]