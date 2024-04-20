#!/bin/bash

# Check if script is being run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" 
    exit 1
fi

# Create Bitwarden user if it doesn't exist
if ! id "bitwarden" &>/dev/null; then
    echo "Creating Bitwarden user..."
    adduser --disabled-password --gecos "" bitwarden
fi

# Create Docker group if it doesn't exist
if ! getent group docker &>/dev/null; then
    echo "Creating Docker group..."
    groupadd docker
fi

# Add Bitwarden user to Docker group
usermod -aG docker bitwarden

# Create Bitwarden directory
echo "Creating Bitwarden directory..."
mkdir -p /opt/bitwarden

# Set permissions for the Bitwarden directory
echo "Setting permissions for Bitwarden directory..."
chmod -R 700 /opt/bitwarden

# Set Bitwarden user as owner of the Bitwarden directory
echo "Setting Bitwarden user as owner of Bitwarden directory..."
chown -R bitwarden:bitwarden /opt/bitwarden

# Download Bitwarden installation script
echo "Downloading Bitwarden installation script..."
curl -Lso /opt/bitwarden/bitwarden.sh "https://func.bitwarden.com/api/dl/?app=self-host&platform=linux"
chmod 700 /opt/bitwarden/bitwarden.sh

# Switch to Bitwarden user and install Bitwarden
echo "Switching to Bitwarden user and installing Bitwarden..."
su - bitwarden -c '/opt/bitwarden/bitwarden.sh install'

echo "Bitwarden installation completed."
