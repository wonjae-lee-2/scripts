#!/bin/bash

# Set the path to the scripts folder.
SCRIPT_FOLDER=~/github/scripts

# Call sub-processes.
${SCRIPT_FOLDER}/packages/python.sh
${SCRIPT_FOLDER}/packages/r.sh
${SCRIPT_FOLDER}/packages/julia.sh
