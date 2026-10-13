# !/bin/bash

#This script is intended to be run to configure a web server and mail server
#after running 'basic_config.sh' script. It will update the system,
#install Apache2, PHP, mariadb and configure UFW firewall rules for a web 
#server and mail server.

#Update existing software
sudo apt update && sudo apt upgrade -y
sudo apt full-upgrade -y

#Install extra software
sudo apt install apache2
sudo apt install php libapache2-mod-php -y
sudo apt install mariadb-server mariadb-client -y

#Set basic UFW rules to be customized per box needs in the future
#Only TCP is allowed since none of the serivces use UDP under
#the Principle of Least Privilege
#I'm using this box to host a webserver and an email server
#Your needs may vary

sudo ufw allow proto tcp from any to any port 25
sudo ufw allow proto tcp from any to any port 80
sudo ufw allow proto tcp from any to any port 110
sudo ufw allow proto tcp from any to any port 143
sudo ufw allow proto tcp from any to any port 443
sudo ufw allow proto tcp from any to any port 465
sudo ufw allow proto tcp from any to any port 587
sudo ufw allow proto tcp from any to any port 993
sudo ufw allow proto tcp from any to any port 995
sudo ufw allow proto tcp from any to any port 2525

#Add a selected user to the default Apache2 group and then give that group
#ownership of the default html folder
usermod -a -G www-data $USER
chown -R -f www-data:www-data /var/www/html
chmod -R 774 /var/www/html

#Start Apache2 web server
sudo systemctl start apache2
