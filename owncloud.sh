#!/bin/bash

# Update and upgrade the system
sudo apt-get update && sudo apt-get upgrade -y

# Install Apache, MySQL, and PHP (the LAMP stack)
sudo apt-get install apache2 mysql-server php libapache2-mod-php php-mysql -y

# Secure MySQL installation (you'll be prompted to set a root password and make other decisions)
sudo mysql_secure_installation

# Create a MySQL database and user for OwnCloud
mysql -u root -p -e "CREATE DATABASE owncloud_db; GRANT ALL ON owncloud_db.* TO 'owncloud_user'@'localhost' IDENTIFIED BY 'your_password'; FLUSH PRIVILEGES;"

# Install additional PHP modules required by OwnCloud
sudo apt-get install php-dom php-gd php-json php-mbstring php-xml php-zip php-curl php-intl php-bcmath php-gmp -y

# Enable Apache modules and restart Apache
sudo a2enmod rewrite headers env dir mime
sudo systemctl restart apache2

# Download and extract OwnCloud
wget https://download.owncloud.org/community/owncloud-latest.tar.bz2
tar -xjf owncloud-latest.tar.bz2
sudo mv owncloud /var/www/

# Set permissions
sudo chown -R www-data:www-data /var/www/owncloud
sudo chmod -R 755 /var/www/owncloud

# Configure Apache for OwnCloud
echo "<VirtualHost *:80>
    DocumentRoot /var/www/owncloud
    <Directory /var/www/owncloud>
        Options +FollowSymlinks
        AllowOverride All

       <IfModule mod_dav.c>
           Dav off
       </IfModule>

       SetEnv HOME /var/www/owncloud
       SetEnv HTTP_HOME /var/www/owncloud
    </Directory>
</VirtualHost>" | sudo tee /etc/apache2/sites-available/owncloud.conf

# Enable the new site and restart Apache
sudo a2ensite owncloud
sudo systemctl restart apache2

# OwnCloud is now installed, access it via your web browser to complete the setup
echo "OwnCloud installation is complete. Access it via your web browser to complete the setup."
