#!/bin/bash

# Check the latest version of Julia. https://julialang.org/

# Install Julia using Juliaup. # https://github.com/JuliaLang/juliaup
curl -fsSL https://install.julialang.org | sh

# Reload the terminal.
. ~/.profile

# Show the installed Julia.
juliaup status

#  Update all or a specific channel to the latest Julia version.
#juliaup update
