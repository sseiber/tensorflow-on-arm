#! /bin/bash

DOCKER_LABEL=$1
docker rm -f $(docker container ls --all | grep ${DOCKER_LABEL} | awk '{print $1}')
docker rm -f $(docker images -a | grep ${DOCKER_LABEL} | awk '{print $3}')
