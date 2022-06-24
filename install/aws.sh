#!/bin/bash

# Set environment variables.
DOWNLOAD_FOLDER=~/downloads
INSTALL_FOLDER=/opt/aws

# Clean up directories and previous downloads.
sudo rm -r ${INSTALL_FOLDER}
sudo rm ~/.aws/
sudo rm ${DOWNLOAD_FOLDER}/awscli-exe-linux-x86_64.zip

# Install dependencies.
sudo apt update
sudo apt install -y unzip

# Download the installation file.
cd ${DOWNLOAD_FOLDER}
wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip

# Unzip the installer.
unzip awscli-exe-linux-x86_64.zip

# Run the install program.
sudo ./aws/install -i ${INSTALL_FOLDER} -b /usr/local/bin

# Uncomment below to update your current installation of the AWS CLI.
#sudo ./aws/install -i $INSTALL_FOLDER -b /usr/local/bin --update

# Confirm the installation.
#aws --version
