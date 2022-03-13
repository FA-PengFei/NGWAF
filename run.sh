#! /bin/bash

# Remove all containers
docker rm -f $(docker ps -a -q)

# Copy New Models over
# rm -rf "./waf/WafApp/saved_model/"
# cp -r "./ML/code/saved_model/" "./waf/WafApp/saved_model/"

# Not sure what this is for yet
# export ADVERTISED_LISTENER="0.0.0.0"
export ADVERTISED_LISTENER=$(ip route get 1 | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | tail -1)

docker-compose build
docker-compose up --remove-orphans