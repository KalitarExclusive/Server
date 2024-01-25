#!/bin/bash

# Update System
sudo apt-get update
sudo apt-get upgrade -y

# Install Apache2, MySQL, PHP (LAMP Stack)
sudo apt-get install apache2 mysql-server php php-mysql libapache2-mod-php php-cli php-cgi php-gd -y

# Start Apache and MySQL on boot
sudo systemctl enable apache2
sudo systemctl enable mysql

# Download FOSSBilling
cd /var/www/html
sudo git clone https://github.com/FOSSBilling/FOSSBilling.git
cd FOSSBilling

# Set permissions
sudo chown -R www-data:www-data /var/www/html/FOSSBilling
sudo chmod -R 755 /var/www/html/FOSSBilling

# Restart Apache to apply changes
sudo systemctl restart apache2

# Secure MySQL Installation (SET YOUR OWN PASSWORD!)
sudo mysql_secure_installation

# Output message
echo "FOSSBilling is now downloaded. Visit your server's IP/domain to finish installation through the web interface."
