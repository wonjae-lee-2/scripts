#!/bin/bash

# Set paths to initial directories.
DOWNLOAD_FOLDER=~/downloads
GITHUB_FOLDER=~/github
GCS_FOLDER=~/gcs
SECRET_FOLDER=~/secret
VENV_FOLDER=~/venv
DLL_FOLDER=~/dll
SCRIPT_FOLDER=~/github/scripts

# Stop entering password for the `sudo` command.
#sudo sed -i "s/%sudo\tALL=(ALL:ALL) ALL/%sudo\tALL=(ALL:ALL) NOPASSWD:ALL/g" /etc/sudoers

# Create initial directories.
mkdir ${DOWNLOAD_FOLDER} ${GITHUB_FOLDER} ${SECRET_FOLDER} ${VENV_FOLDER} ${DLL_FOLDER} ${GCS_FOLDER}

# Move credentials and keys to the `secret` folder.
mv ~/gcloud-key.json ${SECRET_FOLDER}

# Move DLL files to the `dll` folder.
mv ~/*.dll ${DLL_FOLDER}

# Install Rclone.
curl https://rclone.org/install.sh | sudo bash

# Configure Rclone for OneDrive and GCS.
rclone config
# Set the name of the remote as ondrive and gcs.
# For GCS, do not enter "Service Account Credentials JSON file path".

# Test remote connections.
echo onedrive
rclone lsd onedrive:
echo gcs
rclone lsd gcs:

# Mount OneDrive and GCS to WSL.
rclone mount onedrive:backup/github ${GITHUB_FOLDER} --daemon --vfs-cache-mode full
rclone mount gcs: ${GCS_FOLDER} --daemon --vfs-cache-mode full

# Ensure Rclone mounts OneDrive and GCS if they are not mounted already at log in.
cat << EOF >> ~/.profile

# Ensure Rclone mounts OneDrive and GCS if they are not mounted already at log in.
if [ -z "\$(ls -A ${GITHUB_FOLDER})" ]
then
    echo "Mounting OneDrive..."
    rclone mount onedrive:backup/github ${GITHUB_FOLDER} --daemon --vfs-cache-mode full
fi
if [ -z "\$(ls -A ${GCS_FOLDER})" ]
then
    echo "Mounting GCS..."
    rclone mount gcs: ${GCS_FOLDER} --daemon --vfs-cache-mode full
fi
EOF

# Copy the gcloud authentication script to the `secret` folder.
cp ${SCRIPT_FOLDER}/gcloud-auth.sh ${SECRET_FOLDER}

# Install Git.
sudo apt install git

# Generate a new SSH key.
ssh-keygen -t ed25519 # Select the default path and do not set any password.

# Display the new SSH key.
echo
echo "Add the key below to GitHub."
cat ~/.ssh/id_ed25519.pub
echo

# Copy the SSH private key to the `secret` folder.
cp ~/.ssh/id_ed25519 ${SECRET_FOLDER}
