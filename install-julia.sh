#!/bin/bash

# Check the latest version of Julia. https://julialang.org/

# Set environment variables.
DOCKER_FOLDER=~/github/docker

# Install Julia using Juliaup. # https://github.com/JuliaLang/juliaup
curl -fsSL https://install.julialang.org | sh

# Reload the terminal.
. ~/.profile

# Install packages in a new project folder.
julia --project=~/venv/julia-$(julia --version | cut -d " " -f 3) $DOCKER_FOLDER/julia/requirements.jl

#  Update all or a specific channel to the latest Julia version.
#juliaup update
