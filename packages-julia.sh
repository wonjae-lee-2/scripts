#!/bin/bash

# Set environment variables.
PROJECT_FOLDER=~/github
SCRIPT_FOLDER=~/github/scripts
DOCKER_FOLDER=~/github/docker

# Remove environment files.
rm $PROJECT_FOLDER/Project.toml $PROJECT_FOLDER/Manifest.toml $PROJECT_FOLDER/spec-file.txt

# Install packages in the project folder.
julia --project=$PROJECT_FOLDER $SCRIPT_FOLDER/packages-julia.jl

# Copy environment files to the Julia docker folder.
cp -t $DOCKER_FOLDER/julia $PROJECT_FOLDER/Project.toml $PROJECT_FOLDER/Manifest.toml $PROJECT_FOLDER/spec-file.txt
