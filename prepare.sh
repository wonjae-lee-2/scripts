#!/bin/bash

# Set paths to initial directories.
DOWNLOAD_FOLDER=~/downloads
GITHUB_FOLDER=~/github
S3_FOLDER=~/s3
GCS_FOLDER=~/gcs
KEY_FOLDER=~/keys
VENV_FOLDER=~/venv
SCRIPT_FOLDER=~/github/scripts

# Stop entering password for the `sudo` command.
sudo sed -i "s/%sudo\tALL=(ALL:ALL) ALL/%sudo\tALL=(ALL:ALL) NOPASSWD:ALL/g" /etc/sudoers

# Create initial directories.
mkdir ${DOWNLOAD_FOLDER} ${GITHUB_FOLDER} ${KEY_FOLDER} ${VENV_FOLDER} ${S3_FOLDER} ${GCS_FOLDER}

# Move credentials and keys to the `keys` folder.
mv -t ${KEY_FOLDER} ~/key-aws.csv ~/key-gcloud.json

# Make the keys non-executable.
chmod -x ${KEY_FOLDER}/key*

# Install Rclone.
curl https://rclone.org/install.sh | sudo bash

# Show AWS credentials.
echo "Copy and paste the AWS credentials below to Rclone."
cat ${KEY_FOLDER}/key-aws.csv
echo

# Configure Rclone for OneDrive, S3 and GCS.
rclone config
# Set the name of the remote as ondrive, s3 and gcs.
# For GCS, do not enter "Service Account Credentials JSON file path".
# For S3, choose "Enter AWS credentials in the next step".

# Test remote connections.
echo onedrive
rclone lsd onedrive:
echo s3
rclone lsd s3:
echo gcs
rclone lsd gcs:

# Mount OneDrive, S3 and GCS to WSL.
rclone mount onedrive:backup/github ${GITHUB_FOLDER} --daemon --vfs-cache-mode writes
rclone mount s3: ${S3_FOLDER} --daemon --vfs-cache-mode writes
rclone mount gcs: ${GCS_FOLDER} --daemon --vfs-cache-mode writes

# Ensure Rclone mounts OneDrive, S3 and GCS if they are not mounted already at log in.
cat << EOF >> ~/.profile

# Ensure Rclone mounts OneDrive, S3 and GCS if they are not mounted already at log in.
if [ -z "\$(ls -A ${GITHUB_FOLDER})" ]
then
    echo "Mounting OneDrive..."
    rclone mount onedrive:backup/github ${GITHUB_FOLDER} --daemon --vfs-cache-mode writes
fi
if [ -z "\$(ls -A ${S3_FOLDER})" ]
then
    echo "Mounting S3..."
    rclone mount s3: ${S3_FOLDER} --daemon --vfs-cache-mode writes
fi
if [ -z "\$(ls -A ${GCS_FOLDER})" ]
then
    echo "Mounting GCS..."
    rclone mount gcs: ${GCS_FOLDER} --daemon --vfs-cache-mode writes
fi
EOF

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
cp ~/.ssh/id_ed25519 ${KEY_FOLDER}
