#!/bin/bash

# Check if `PYTHON_VERSION` exists. If not, ask for user input.
if [ -z ${PYTHON_VERSION} ]
then
    echo
    read -p "Which version of Python would you like to install packages for? " PYTHON_VERSION
fi

# Set environment variables.
VENV_FOLDER=~/venv/python/$PYTHON_VERSION
SCRIPT_FOLDER=~/github/scripts
DOCKER_FOLDER=~/github/docker

# Remove the existing virtual environment.
rm -r $VENV_FOLDER

# Create a new virtual environment.
python$PYTHON_VERSION -m venv $VENV_FOLDER

# Activate the virtiual environment.
. $VENV_FOLDER/bin/activate

# Install package management tools.
pip install -U pip setuptools wheel

# Install and upgrade packages.
pip install -U -r $SCRIPT_FOLDER/packages/requirements.txt

# Create requirements.txt in the Python docker folder.
pip freeze --all > $DOCKER_FOLDER/python/requirements.txt

# Deactivate the virtual environment.
deactivate
