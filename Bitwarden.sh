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

# Install Certbot for Let's Encrypt
sudo snap install core; sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

# Run Bitwarden setup
./bitwarden.sh install

# Obtain SSL certificate
echo "Please enter your domain name (e.g., bitwarden.example.com): "
read DOMAIN_NAME
sudo certbot certonly --standalone -d $DOMAIN_NAME

# Configure Bitwarden to use the SSL certificate
sudo ./bitwarden.sh renewssl $DOMAIN_NAME

# Start Bitwarden
./bitwarden.sh start

