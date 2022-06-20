#!/bin/bash

echo "Check the latest version of R. https://www.r-project.org/"
echo
read -p "Which version of R would you like to install? " INPUT
if [ -z $INPUT ]
then
    echo "Please enter a version number as the first argument."
    exit 1
else
    # Set environment variables.
    R_VERSION=$INPUT
    DOWNLOAD_FOLDER=~/downloads

    # Install dependencies.
    sudo apt update
    sudo apt install -y gdebi-core

    # Download R from RStudio.
    cd $DOWNLOAD_FOLDER
    curl -O https://cdn.rstudio.com/r/ubuntu-2204/pkgs/r-${R_VERSION}_1_amd64.deb

    # Install R.
    sudo gdebi -n r-${R_VERSION}_1_amd64.deb

    # Create a symlink to R.
    sudo ln -fs /opt/R/${R_VERSION}/bin/R /usr/local/bin/R
    sudo ln -fs /opt/R/${R_VERSION}/bin/Rscript /usr/local/bin/Rscript
fi
