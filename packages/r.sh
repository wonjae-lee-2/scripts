#!/bin/bash

# Check if `R_VERSION` exists. If not, ask for user input.
if [ -z ${R_VERSION} ]
then
    echo
    read -p "Which version of R would you like to install pakcages for? " R_VERSION
fi

# Set environment variables.
export PROJECT_FOLDER=~/venv/r/$R_VERSION
export LINUX_CODENAME=$(lsb_release -cs)
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

# Install packages.
Rscript $SCRIPT_FOLDER/packages/requirements.r

# Copy renv files to the R docker folder.
cp -t $DOCKER_FOLDER/r $PROJECT_FOLDER/renv.lock $PROJECT_FOLDER/.Rprofile
cp -t $DOCKER_FOLDER/r/renv $PROJECT_FOLDER/renv/activate.R $PROJECT_FOLDER/renv/settings.dcf
