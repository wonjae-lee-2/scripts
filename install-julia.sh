#!/bin/bash

# Check the latest version of Julia. https://julialang.org/

read -p "Which version of Julia would you like to install? " INPUT
if [ -z $INPUT ]
then
    echo "Please enter a version number as the first argument."
    exit 1
else
    # Set environment variables.
    JULIA_VERSION=$INPUT
    JULIA_VERSION_SHORT=$(echo $JULIA_VERSION | cut -d "." -f -2)
    DOWNLOAD_FOLDER=~/downloads
    INSTALL_FOLDER=/opt/julia-$JULIA_VERSION
    PROJECT_FOLDER=~/venv/julia-$JULIA_VERSION
    SCRIPT_FOLDER=~/github/scripts

    # Clean up the directories of the same version.
    sudo rm -r $INSTALL_FOLDER
    sudo rm -r $PROJECT_FOLDER
    
    # Download the Julia binary.
    cd $DOWNLOAD_FOLDER
    wget https://julialang-s3.julialang.org/bin/linux/x64/$JULIA_VERSION_SHORT/julia-$JULIA_VERSION-linux-x86_64.tar.gz
    
    # Extract the binary file.
    sudo mkdir $INSTALL_FOLDER
    sudo tar -x -f julia-$JULIA_VERSION-linux-x86_64.tar.gz -C $INSTALL_FOLDER --strip-components=1

    # Create a symlink to Julia.
    sudo ln -fs /opt/julia-$JULIA_VERSION/bin/julia /usr/local/bin/julia-$JULIA_VERSION
    
    # Create a project and install packages.
    julia-$JULIA_VERSION --project=$PROJECT_FOLDER $SCRIPT_FOLDER/docker-julia/requirements.jl
fi
