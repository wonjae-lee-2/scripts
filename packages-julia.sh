#!/bin/bash

# Set environment variables.
PROJECT_FOLDER=~/github
DOCKER_FOLDER=~/github/docker

# Install packages in the project folder.
julia --project=$PROJECT_FOLDER packages-julia.jl

# Copy environment files to the Julia docker folder.
cp -t $DOCKER_FOLDER/julia $PROJECT_FOLDER/Project.toml $PROJECT_FOLDER/Manifest.toml $PROJECT_FOLDER/spec-file.txt

# Stop the Julia container.
docker stop docker-julia-1

# Remove the Julia container.
docker rm docker-julia-1

# Remove the Julia image.
docker rmi $(docker images docker/julia -q)

# Build the Julia image.
cd $DOCKER_FOLDER
docker compose build --no-cache julia
