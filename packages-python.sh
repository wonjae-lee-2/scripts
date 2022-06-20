#!/bin/bash

# Ask the Python version.
read -p "For which Python version would you like to install packages? " PYTHON_VERSION

# Set environment variables.
VENV_FOLDER=~/venv/$PYTHON_VERSION
SCRIPT_FOLDER=~/github/scripts
DOCKER_FOLDER=~/github/docker

# Remove the existing virtual environment.
rm -r $VENV_FOLDER

# Create a new virtual environment.
python$PYTHON_VERSION -m venv $VENV_FOLDER

# Activate the virtiual environment.
. $VENV_FOLDER/bin/activate

# Install and upgrade packages.
pip install -U -r $SCRIPT_FOLDER/packages-python.txt

# Create requirements.txt in the Python docker folder.
pip freeze --all > $DOCKER_FOLDER/python/requirements.txt

# Deactivate the virtual environment.
deactivate
