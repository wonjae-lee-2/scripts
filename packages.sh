#!/bin/bash

# Set the path to the scripts folder.
SCRIPT_FOLDER=~/github/scripts

# Call sub-processes.
bash ${SCRIPT_FOLDER}/packages/python.sh
bash ${SCRIPT_FOLDER}/packages/r.sh
bash ${SCRIPT_FOLDER}/packages/julia.sh
