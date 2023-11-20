#!/bin/bash

# Update package list and install Nginx
sudo apt update
sudo apt install nginx -y

# Start and enable Nginx service
sudo systemctl start nginx
sudo systemctl enable nginx

# Define your domain names and corresponding port numbers
declare -A domains=( ["simple-streams.com"]="8096"

# Create Nginx server blocks for each domain
for domain in "${!domains[@]}"; do
    config="/etc/nginx/sites-available/$domain"
    port=${domains[$domain]}

    # Create the server block configuration
    echo "Creating Nginx server block for $domain on port $port"
    cat <<EOF | sudo tee $config
server {
    listen 80;
    server_name simple-streams.com;

    location / {
        proxy_pass http://45.63.58.19:8096;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

    # Enable the configuration
    sudo ln -s $config /etc/nginx/sites-enabled/
done

# Test Nginx configuration and restart the service
sudo nginx -t && sudo systemctl restart nginx

echo "Nginx configuration complete. If there were no errors, your reverse proxy is now set up."
