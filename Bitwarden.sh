#!/bin/bash

# Update system packages
sudo apt update && sudo apt upgrade -y

# Install Docker if it's not already installed
if ! [ -x "$(command -v docker)" ]; then
    echo "Installing Docker..."
    sudo apt install docker.io -y
fi

# Start Docker if it's not running
sudo systemctl start docker
sudo systemctl enable docker

# Install Docker Compose
sudo apt install docker-compose -y

# Download Bitwarden setup script
curl -Lso bitwarden.sh https://go.btwrdn.co/bw-sh
chmod +x bitwarden.sh

# Run Bitwarden setup
./bitwarden.sh install

# Start Bitwarden
./bitwarden.sh start
