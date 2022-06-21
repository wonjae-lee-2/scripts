#!/bin/bash

# Ask the Julia version.
read -p "For which Julia version would you like to install packages? " JULIA_VERSION

# Set environment variables.
export PROJECT_FOLDER=~/venv/julia/$JULIA_VERSION
SCRIPT_FOLDER=~/github/scripts
DOCKER_FOLDER=~/github/docker

# Remove environment files.
rm $PROJECT_FOLDER/Project.toml $PROJECT_FOLDER/Manifest.toml $PROJECT_FOLDER/spec-file.txt

# Install packages in the project folder.
julia --project=$PROJECT_FOLDER $SCRIPT_FOLDER/packages-julia.jl

# Copy environment files to the Julia docker folder.
cp -t $DOCKER_FOLDER/julia $PROJECT_FOLDER/Project.toml $PROJECT_FOLDER/Manifest.toml $PROJECT_FOLDER/spec-file.txt
