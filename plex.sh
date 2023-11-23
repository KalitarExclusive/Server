#!/bin/bash

# Add Plex Repository
echo "Adding Plex repository..."
echo deb [signed-by=/usr/share/keyrings/plex.gpg] https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list

# Import GPG Key
echo "Importing GPG key for Plex..."
sudo wget -O- https://downloads.plex.tv/plex-keys/PlexSign.key | gpg --dearmor | sudo tee /usr/share/keyrings/plex.gpg

# Update System
echo "Updating system packages..."
sudo apt update

# Install Plex Media Server
echo "Installing Plex Media Server..."
sudo apt install plexmediaserver -y

# Start and Enable Plex Service
echo "Starting Plex Media Server..."
sudo systemctl start plexmediaserver
sudo systemctl enable plexmediaserver


echo "Plex Media Server installation completed."
