#!/bin/bash

# Ask the R version.
read -p "For which R version would you like to install packages? " R_VERSION

# Set environment variables.
export PROJECT_FOLDER=~/venv/r/$R_VERSION
SCRIPT_FOLDER=~/github/scripts
DOCKER_FOLDER=~/github/docker

# Install package dependencies.
sudo apt update
sudo apt install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libpq-dev \
    libxml2-dev
    # libcurl4-openssl-dev - curl
    # libssl-dev - curl, GGally
    # libpq-dev - RPostgres
    # libxml2-dev - xml2

# Remove renv infrastructure files.
rm -r $PROJECT_FOLDER/.Rprofile $PROJECT_FOLDER/renv.lock $PROJECT_FOLDER/renv

# Ask the R version.
Rscript $SCRIPT_FOLDER/packages-r.r

# Copy renv files to the R docker folder.
cp -t $DOCKER_FOLDER/r $PROJECT_FOLDER/renv.lock $PROJECT_FOLDER/.Rprofile
mkdir $DOCKER_FOLDER/r/renv
cp -t $DOCKER_FOLDER/r/renv $PROJECT_FOLDER/renv/activate.R $PROJECT_FOLDER/renv/settings.dcf
