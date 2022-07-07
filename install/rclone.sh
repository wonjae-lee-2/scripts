#!/bin/bash

# Check the latest version of Rclone. https://rclone.org/

# Install Rclone.
curl https://rclone.org/install.sh | sudo bash

# Configure Rclone for OneDrive, S3 and GCS.
rclone config
# Set the name of the remote as ondrive, s3 and gcs.
# For GCS, enter "Service Account Credentials JSON file path".
# For S3, choose "Enter AWS credentials in the next step".

# Test the remote connection with OneDrive.
echo onedrive
rclone lsd onedrive:

# Test the remote connection with S3.
echo s3
rclone lsd s3:

# Test the remote connection with Google Cloud Storage.
echo gcs
rclone lsd gcs:
