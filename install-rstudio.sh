#!/bin/bash

# Check the latest version of RStudio. https://www.rstudio.com/

read -p "Which version of RStudio would you like to install? " INPUT
if [ -z $INPUT ]
then
    echo "Please enter a version number as the first argument."
    exit 1
else
    # Set environment variables.
    RSTUDIO_VERSION=$(echo $INPUT | sed 's/+/-/')
    DOWNLOAD_FOLDER=~/downloads/

    # Install build dependencies.
    sudo apt update
    sudo apt install gdebi-core
    
    # Download RStudio Server from the official website.
    # cd $DOWNLOAD_FOLDER
    # wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-$RSTUDIO_VERSION-amd64.deb

    # Download RStudio Server daily builds. https://dailies.rstudio.com/
    cd $DOWNLOAD_FOLDER
    wget https://s3.amazonaws.com/rstudio-ide-build/server/$(lsb_release -cs)/amd64/rstudio-server-$RSTUDIO_VERSION-amd64.deb

    # Install RStudio Server.
    sudo gdebi -n rstudio-server-$RSTUDIO_VERSION-amd64.deb

    # Stop RStudio Server.
    sudo systemctl stop rstudio-server

    # Stop RStudio Server from starting automatically at startup.
    sudo systemctl disable rstudio-server
fi
