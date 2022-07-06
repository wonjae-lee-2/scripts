#!/bin/bash

# Set paths to initial directories.
DOWNLOAD_FOLDER=~/downloads
KEY_FOLDER=~/keys
VENV_FOLDER=~/venv
SCRIPT_FOLDER=~/github/scripts
SSH_FOLDER=~/.ssh

# Create initial directories.
mkdir ${DOWNLOAD_FOLDER} ${KEY_FOLDER} ${VENV_FOLDER}

# Move credentials and keys to the `keys` folder.
mv -t ${KEY_FOLDER} ~/key-aws.csv ~/key-gcloud.json

# Move the AWS private key to the `ssh` folder and restrict access by other users.
mv ~/us-east-1.pem ${SSH_FOLDER}
chmod 600 ${SSH_FOLDER}/us-east-1.pem

# Copy the gcloud authentication script to the `keys` folder.
cp ${SCRIPT_FOLDER}/gcloud-auth.sh ${KEY_FOLDER}

# Copy the SSH private key to the `keys` folder.
cp ${SSH_FOLDER}/id_ed25519 ${KEY_FOLDER}
