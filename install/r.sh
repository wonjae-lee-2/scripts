#!/bin/bash

if [ -z ${R_VERSION} ]
then
    echo
    echo "Check the latest version of R. https://www.r-project.org"
    read -p "Which version of R would you like to install? " R_VERSION
fi

# Set environment variables. R_VERSION is either exported from `install.sh` or read from user input.
DOWNLOAD_FOLDER=~/downloads

# Remove previous downloads of the same version.
sudo rm ${DOWNLOAD_FOLDER}/r-${R_VERSION}_1_amd64.deb

# Install dependencies.
sudo apt update
sudo apt install -y gdebi-core

# Download R from RStudio.
cd ${DOWNLOAD_FOLDER}
curl -O https://cdn.rstudio.com/r/ubuntu-2204/pkgs/r-${R_VERSION}_1_amd64.deb

# Install R.
sudo gdebi -n r-${R_VERSION}_1_amd64.deb

# Create a symlink to R.
sudo ln -fs /opt/R/${R_VERSION}/bin/R /usr/local/bin/R
sudo ln -fs /opt/R/${R_VERSION}/bin/Rscript /usr/local/bin/Rscript
