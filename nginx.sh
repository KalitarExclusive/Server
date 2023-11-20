#!/bin/bash

# Update package list and install Nginx
sudo apt update
sudo apt install nginx -y

# Start and enable Nginx service
sudo systemctl start nginx
sudo systemctl enable nginx

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
        proxy_pass http://45.63.58.19:$8096;
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

# Install Certbot and its Nginx plugin
sudo apt install certbot python3-certbot-nginx -y

# Obtain and install Let's Encrypt certificates for each domain
for domain in "${!domains[@]}"; do
    sudo certbot --nginx -d $domain --redirect --agree-tos --no-eff-email --email your-email@example.com
done

echo "Nginx configuration complete. If there were no errors, your reverse proxy and SSL setup is now complete."
