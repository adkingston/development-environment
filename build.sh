#!/bin/bash

# if the base image does not exist, build it
if [[ "$(docker image ls | grep -cE 'sp_dev\s{1,}go')" -lt 1 ]]; 
then
    echo "building base golang image"
    docker build -t base:go -f Dockerfile.golang .
else 
    echo "base golang image already exists"
fi

# if the dev image does not exist, create it 
if [[ "$(docker image ls | grep -cE 'dev\s{1,}adk')" -lt 1 ]]; 
then 
    echo "building adk development image"
    docker build -t dev:adk --build-arg build_tag=sp_dev:go -f Dockerfile.nvim .
else 
    echo "adk development image already exists"
fi

# if the volume does not exist, create it (make variable so it can be named)
if [[ "$(docker volume ls | grep -c akingston)" -lt 1 ]];
then 
    echo "creating volume"
    docker volume create --name local-workspace-adkingston
else 
    echo "development volume already exists"
fi

# if the service does not exist, make it
if [[ "$(docker service ls | grep -c adk_dev)" -lt 1 ]]; 
then 
    echo "creating service"
   docker service create -t --name adk_dev \
                            --network iims_backend \
                            -p 3030:3030 -p 3000:3000 \
                            --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
                            dev:adk
else 
    echo "development service already exists"
fi

echo "entering development container"
# exec into the container
echo $(docker ps | grep adk_dev | awk -F " " '{ print $NF }')
docker exec -it $(docker ps | grep adk_dev | awk -F " " '{ print $NF }') zsh