#!/bin/bash

# Check the latest version of Node.js. https://nodejs.org/en/

# Install Node Version Manager.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Start nvm.
. ~/.nvm/nvm.sh

# Install the latest version of Node.js.
nvm install node

# Show the version of the installed Node.js.
node --version
