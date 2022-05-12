#!/bin/bash

# Check the latest version of Rust. https://www.rust-lang.org/

# Install Rust.
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Reload the terminal.
. ~/.profile

# Update Rust.
rustup update
