#!/bin/bash

# Check the latest version of RStudio. https://www.rstudio.com/

if [ -z $1 ]
then
    echo "Please enter a version number as the first argument."
    exit 1
else
    # Set environment variables.
    RSTUDIO_VERSION=$(echo $1 | sed 's/+/-/')
    DOWNLOAD_FOLDER=~/downloads/
    SCRIPT_FOLDER=~/github/scripts

    # Remove previously installed RStudio.
    sudo apt remove rstudio-server

    # Install build dependencies.
    sudo apt install gdebi-core
    
    # Download RStudio from the official website.
    # cd $DOWNLOAD_FOLDER
    # wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-$RSTUDIO_VERSION-amd64.deb

    # Download RStudio daily builds. https://dailies.rstudio.com/
    cd $DOWNLOAD_FOLDER
    wget https://s3.amazonaws.com/rstudio-ide-build/server/$(lsb_release -cs)/amd64/rstudio-server-$RSTUDIO_VERSION-amd64.deb

    # Install RStudio
    sudo gdebi -n rstudio-server-$RSTUDIO_VERSION-amd64.deb

    # Install package dependencies.
    sudo apt install -y \
        libcurl4-openssl-dev \
        libxml2-dev \
        libpq-dev \
        libssl-dev \
        libmariadb-dev

    /home/ubuntu/R/x86_64-pc-linux-gnu-library/4.2

    # Install packages.
    cd $SCRIPT_FOLDER
    Rscript ./docker-r/requirements.r
fi
