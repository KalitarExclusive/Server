#!/bin/bash

# Update the system's package list
sudo apt-get update

# Install rclone
sudo apt-get install rclone -y

# Verify the installation
rclone --version

# Basic configuration (optional, can be run manually later)
# rclone config
