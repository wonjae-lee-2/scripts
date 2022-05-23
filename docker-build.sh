#!/bin/bash

read -p "Which language would you like to build? " INPUT1
read -p "Which version would you like to build? " INPUT2
if [ $INPUT1 = "julia" ]
then
    docker rmi $(docker images lee/julia -aq)
    DOCKER_BUILDKIT=1 docker build --no-cache -t lee/julia:$INPUT2 ./docker-julia
elif [ $INPUT1 = "python" ]
then
    docker rmi $(docker images lee/python -aq)
    DOCKER_BUILDKIT=1 docker build --no-cache -t lee/python:$INPUT2 ./docker-python
elif [ $INPUT1 = "r" ]
then
    docker rmi $(docker images lee/r -aq)
    DOCKER_BUILDKIT=1 docker build --no-cache -t lee/r:$INPUT2 ./docker-r
fi
