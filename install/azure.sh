#!/bin/bash

# Install Azure CLI.
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Log in with the browser on the local machine.
az login --allow-no-subscriptions --use-device-code
