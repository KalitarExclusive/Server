#!/bin/bash

# Update system packages
sudo apt update && sudo apt upgrade -y

# Install HTTPS transport for APT if not already installed
sudo apt install apt-transport-https -y

# Add the Jellyfin repository to your APT sources
wget -O - https://repo.jellyfin.org/ubuntu/jellyfin_team.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/jellyfin.gpg
echo "deb [signed-by=/usr/share/keyrings/jellyfin.gpg] https://repo.jellyfin.org/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/jellyfin.list

# Update APT repositories
sudo apt update

# Install Jellyfin
sudo apt install jellyfin -y

# Enable and start the Jellyfin service
sudo systemctl enable jellyfin
sudo systemctl start jellyfin
