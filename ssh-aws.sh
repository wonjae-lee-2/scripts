#!/bin/bash

# Move the AWS private key to the `ssh` folder.
mv ~/us-east-1.pem ~/.ssh

# Restrict access to the key by other users.
chmod 600 ~/.ssh/us-east-1.pem

# Create the OpenSSH `config` file on WSL.
cat << EOF > ~/.ssh/config
Host aws
   Hostname ec2-3-83-6-11.compute-1.amazonaws.com
   User ubuntu
   IdentityFile ~/.ssh/us-east-1.pem
EOF

# Delete the OpenSSH `known_hosts` file on the local machine.
rm ~/.ssh/known_hosts*
