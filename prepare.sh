#!/bin/bash

# Set paths to initial directories.
DOWNLOAD_FOLDER=~/downloads
KEY_FOLDER=~/keys
VENV_FOLDER=~/venv
SCRIPT_FOLDER=~/github/scripts

# Set the new password for the user `ubuntu`.
echo "Enter a new password for ubuntu"
sudo passwd ubuntu

# Create initial directories.
mkdir ${DOWNLOAD_FOLDER} ${KEY_FOLDER} ${VENV_FOLDER}

# Move credentials and keys to the `keys` folder.
mv -t ${KEY_FOLDER} ~/key-aws.csv ~/key-gcloud.json

# Copy the gcloud authentication script to the `keys` folder.
cp ${SCRIPT_FOLDER}/gcloud-auth.sh ${KEY_FOLDER}
