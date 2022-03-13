#! /bin/bash

# Remove all docker container
docker rm -f $(docker ps -aq)

# Clear all docker images, volumes,networks etc
# docker system prune -f -a
docker volume prune -f
