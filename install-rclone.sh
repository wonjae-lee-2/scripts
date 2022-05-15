#!/bin/bash

# Check the latest version of Rclone. https://rclone.org/

# Install Rclone.
sudo apt update
sudo apt install -y rclone

# Configure Rclone for OneDrive.
rclone config # Set the name of the remote as ondrive. Quit after setting up connection to OneDrive.

# Test the remote connection with OneDrive.
rclone lsd onedrive:

# Install AWS CLI.
sudo apt install -y awscli

# Configure AWS CLI with credentials in the personal vault.
aws configure

# Configure Rclone for S3.
rclone config # Set the name of the remote as s3. Choose 'Get AWS credentials from the environment'.

# Test the remote connection with S3.
rclone lsd s3:
