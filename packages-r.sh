#!/bin/bash

# Set environment variables.
PROJECT_FOLDER=~/github
DOCKER_FOLDER=~/github/docker

# Install package dependencies.
sudo apt update
sudo apt install -y \
    libcurl4-openssl-dev \
    libxml2-dev \
    libpq-dev \
    libssl-dev

# Ask the R version.
Rscript packages-r.r

# Copy renv files to the R docker folder.
cp -t $DOCKER_FOLDER/r $PROJECT_FOLDER/renv.lock $PROJECT_FOLDER/.Rprofile
mkdir $DOCKER_FOLDER/r/renv
cp -t $DOCKER_FOLDER/r/renv $PROJECT_FOLDER/renv/activate.R $PROJECT_FOLDER/renv/settings.dcf

# Stop the R container.
docker stop docker-r-1

# Remove the R container.
docker rm docker-r-1

# Remove the R image.
docker rmi $(docker images docker/r -q)

# Build the R image.
cd $DOCKER_FOLDER
docker compose build --no-cache r
