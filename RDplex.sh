#!/bin/bash

# Update and Upgrade Ubuntu
sudo apt-get update
sudo apt-get upgrade -y

# Install screen, git, Python3, and pip
sudo apt-get install -y screen git python3 python3-pip

# Install rclone for realdebrid
wget https://github.com/itsToggle/rclone_RD/releases/download/v1.58.1-rd.2.2/rclone-linux
chmod u+x ./rclone-linux

# Automatically configuring rclone with realdebrid is complex, as it requires user input
# Run './rclone-linux config' manually to configure realdebrid

# Create a torrents directory
mkdir ~/torrents

# Plex Installation (adjust as per your system's requirements)
# Visit https://www.plex.tv/media-server-downloads/ for more instructions
curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
sudo apt-get update
sudo apt-get install -y plexmediaserver

# Clone and set up plex_debrid
git clone https://github.com/itsToggle/plex_debrid
pip3 install -r ./plex_debrid/requirements.txt

# Reminder for manual steps
echo "Please remember to manually configure rclone, Plex libraries, and plex_debrid."

# End of script
