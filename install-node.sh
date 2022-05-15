#!/bin/bash

# Check the latest version of Node.js. https://nodejs.org/en/

if [ -z $1 ]
then
    echo "Please enter a version number as the first argument."
    exit 1
else
    # Set environment variables.
    NODE_VERSION=$1
    DOWNLOAD_FOLDER=~/downloads
    INSTALL_FOLDER=/opt/node-$NODE_VERSION

    # Clean up the directory of the same version.
    sudo rm -r $INSTALL_FOLDER
    
    # Download the Node.js binary.
    cd $DOWNLOAD_FOLDER
    wget https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz
    
    # Extract the binary file.
    sudo mkdir $INSTALL_FOLDER
    sudo tar -x -f node-v$NODE_VERSION-linux-x64.tar.xz -C $INSTALL_FOLDER --strip-components=1
    
    # Add the Node.js directory to $PATH.
    sed -i "/\/opt\/node-/d" ~/.profile
    echo PATH="$INSTALL_FOLDER/bin:\$PATH" >> ~/.profile
fi
