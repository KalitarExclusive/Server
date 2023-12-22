#!/bin/bash

# Update the package list
sudo apt-get update

# Install Nginx
sudo apt-get install -y nginx

# Create a backup of the original Nginx configuration
sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup

# Write the new configuration
sudo bash -c 'cat > /etc/nginx/conf.d/66.42.98.190.conf' << 'EOL'
server {
    listen 80;
    server_name 66.42.98.190;

    # Define the cache path, keys, and cache durations
    proxy_cache_path /cache/ts levels=1:2 keys_zone=my_cache:10m max_size=10g inactive=60m use_temp_path=off;

    location / {
        proxy_pass http://ky-iptv.com:80;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_cache off;
    }

    location ~* \.ts$ {
        proxy_pass http://ky-iptv.com:80/armando68/macias342/517452.ts;
        proxy_cache my_cache;
        proxy_cache_valid 200 302 10m;
        proxy_cache_valid 404 1m;
        proxy_cache_methods GET HEAD;
        proxy_cache_lock on;
        add_header X-Proxy-Cache $upstream_cache_status;
        proxy_cache_key "$scheme$request_method$host$request_uri$is_args$args";
    }
}
EOL

# Ensure the cache directory exists and set proper permissions
sudo mkdir -p /cache/ts
sudo chown www-data:www-data /cache/ts

# Restart Nginx to apply the new configuration
sudo systemctl restart nginx

# Output the status of Nginx
sudo systemctl status nginx
