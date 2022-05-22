#!/bin/bash

JULIA_VERSION="1.7.2"
PYTHON_VERSION="3.10.4"
R_VERSION="4.2.0"

if [ $1 = "julia" ]
then
    docker rmi $(docker images lee/julia -aq)
    DOCKER_BUILDKIT=1 docker build --no-cache -t lee/julia:$JULIA_VERSION ./docker-julia
elif [ $1 = "python" ]
then
    docker rmi $(docker images lee/python -aq)
    DOCKER_BUILDKIT=1 docker build --no-cache -t lee/python:$PYTHON_VERSION ./docker-python
elif [ $1 = "r" ]
then
    docker rmi $(docker images lee/r -aq)
    DOCKER_BUILDKIT=1 docker build --no-cache -t lee/r:$R_VERSION ./docker-r
fi
