#!/bin/bash

if [ -z ${RSTUDIO_VERSION} ]
then
    echo
    echo "Check the latest version of RStudio. https://www.rstudio.com or https://dailies.rstudio.com"
    read -p "Which version of RStudio would you like to install? " RSTUDIO_VERSION
fi

# Set environment variables. RSTUDIO_VERSION is either exported from `install.sh` or read from user input.
RSTUDIO_VERSION_FILENAME=$(echo $RSTUDIO_VERSION | sed 's/+/-/')
DOWNLOAD_FOLDER=~/downloads/

# Remove previous downloads of the same version.
sudo rm ${DOWNLOAD_FOLDER}/rstudio-server-${RSTUDIO_VERSION_FILENAME}-amd64.deb

# Install build dependencies.
sudo apt update
sudo apt install gdebi-core

# Download RStudio Server from the official website.
#cd ${DOWNLOAD_FOLDER}
#wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-${RSTUDIO_VERSION_FILENAME}-amd64.deb

# Download RStudio Server daily builds.
cd ${DOWNLOAD_FOLDER}
wget https://s3.amazonaws.com/rstudio-ide-build/server/$(lsb_release -cs)/amd64/rstudio-server-${RSTUDIO_VERSION_FILENAME}-amd64.deb

# Install RStudio Server.
sudo gdebi -n rstudio-server-${RSTUDIO_VERSION_FILENAME}-amd64.deb

# Stop RStudio Server.
sudo systemctl stop rstudio-server

# Stop RStudio Server from starting automatically at startup.
sudo systemctl disable rstudio-server
