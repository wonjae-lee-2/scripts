#!/bin/bash

# Check the latest version of Rclone. https://rclone.org/

# Install Rclone.
curl https://rclone.org/install.sh | sudo bash

# Configure Rclone for OneDrive and S3.
rclone config # Set the name of the remote as ondrive and s3. For S3, choose 'Get AWS credentials from the environment'. Quit after setting up connection to OneDrive and S3.

# Test the remote connection with OneDrive.
echo onedrive
rclone lsd onedrive:

# Test the remote connection with S3.
echo s3
rclone lsd s3:
