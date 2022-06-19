#!/bin/bash

# Ask the Python version.
read -p "For which Python version would you like to install packages? " PYTHON_VERSION

# Set environment variables.
VENV_FOLDER=~/venv/python/$PYTHON_VERSION
DOCKER_FOLDER=~/github/docker

# Activate the virtiual environment.
. $VENV_FOLDER/bin/activate

# Install and upgrade packages.
pip install -U -r packages-python.txt

# Create requirements.txt in the Python docker folder.
pip freeze --all > $DOCKER_FOLDER/python/requirements.txt

# Deactivate the virtual environment.
deactivate

# Stop the Python container.
docker stop docker-python-1

# Remove the Python container.
docker rm docker-python-1

# Remove the Python image.
docker rmi $(docker images docker/python -q)

# Build the Python image.
cd $DOCKER_FOLDER
docker compose build --no-cache python
