#!/bin/bash

# Set paths to initial directories.
DOWNLOAD_FOLDER=~/downloads
GITHUB_FOLDER=~/github
KEY_FOLDER=~/keys
VENV_FOLDER=~/venv
SCRIPT_FOLDER=~/github/scripts
SSH_FOLDER=~/.ssh

# Create initial directories.
mkdir ${DOWNLOAD_FOLDER} ${GITHUB_FOLDER} ${KEY_FOLDER}  ${SSH_FOLDER} ${VENV_FOLDER}

# Move credentials and keys to the `keys` folder.
mv -t ${KEY_FOLDER} ~/key-aws.csv ~/key-gcloud.json

# Make the keys non-executable.
chmod -x ${KEY_FOLDER}/key*

# Move the AWS private key to the `ssh` folder.
mv ~/us-east-1.pem ${SSH_FOLDER}

# Restrict access to the key by other users.
chmod 600 ${SSH_FOLDER}/us-east-1.pem

# Install Rclone.
curl https://rclone.org/install.sh | sudo bash

# Show AWS credentials.
echo "Past the AWS credentials below to Rclone."
cat ${KEY_FOLDER}/key-aws.csv
echo

# Configure Rclone for OneDrive, S3 and GCS.
rclone config
# Set the name of the remote as ondrive, s3 and gcs.
# For GCS, enter "Service Account Credentials JSON file path".
# For S3, choose "Enter AWS credentials in the next step".

# Test remote connections.
echo onedrive
rclone lsd onedrive:
echo s3
rclone lsd s3:
echo gcs
rclone lsd gcs:

# Mount OneDrive to the GitHub folder.
rclone mount onedrive:backup/github ${GITHUB_FOLDER} --daemon --vfs-cache-mode writes

# Ensure Rclone mount OneDrive at startup.
echo "rclone mount onedrive:backup/github ${GITHUB_FOLDER} --daemon --vfs-cache-mode writes" >> ~/.profile

# Copy the gcloud authentication script to the `keys` folder.
cp ${SCRIPT_FOLDER}/gcloud-auth.sh ${KEY_FOLDER}

# Install Git.
sudo apt install git

# Generate a new SSH key.
ssh-keygen -t ed25519 # Select the default path and do not set any password.

# Display the new SSH key.
echo
echo "Add the key below to GitHub."
cat ~/.ssh/id_ed25519.pub
echo

# Copy the SSH private key to the `keys` folder.
cp ${SSH_FOLDER}/id_ed25519 ${KEY_FOL