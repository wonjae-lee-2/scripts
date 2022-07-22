#!/bin/bash

# Check the latest version of Julia. https://julialang.org/

# Install Julia using Juliaup. # https://github.com/JuliaLang/juliaup
curl -fsSL https://install.julialang.org | sh

# Create a symlink to Julia.
sudo ln -fs ~/.julia/juliaup/bin/julia /usr/local/bin/julia

# Show the installed Julia.
#juliaup status

#  Update all or a specific channel to the latest Julia version.
#juliaup update
