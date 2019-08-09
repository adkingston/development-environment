#!bin/bash

if output=$(docker image ls | grep godev) && [[ -z $output ]] 
then
    echo "building go-iamge"
    docker build -t godev -f Dockerfile.golang .
fi 

echo "building development environment"
docker build -t dev-env -f dockerfile.base .
