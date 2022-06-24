#!/bin/bash

# Check if `JULIA_VERSION` exists. If not, ask for user input.
if [ -z ${JULIA_VERSION} ]
then
    echo
    echo "Check the latest version of Julia. https://julialang.org/"
    read -p "Which version of Julia would you like to install? " JULIA_VERSION
fi

# Set environment variables.
export PROJECT_FOLDER=~/venv/julia/$JULIA_VERSION
SCRIPT_FOLDER=~/github/scripts
DOCKER_FOLDER=~/github/docker

# Remove environment files.
rm $PROJECT_FOLDER/Project.toml $PROJECT_FOLDER/Manifest.toml $PROJECT_FOLDER/spec-file.txt

# Install packages in the project folder.
julia --project=$PROJECT_FOLDER $SCRIPT_FOLDER/packages/requirements.jl

# Copy environment files to the Julia docker folder.
cp -t $DOCKER_FOLDER/julia $PROJECT_FOLDER/Project.toml $PROJECT_FOLDER/Manifest.toml $PROJECT_FOLDER/spec-file.txt
