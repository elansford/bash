# !/bin/bash

#Update existing software
apt update && apt upgrade -y
apt full-upgrade -y

#Install extra software
apt install ufw
apt install apache2

#Set basic UFW rules to be customized per box needs in the future
ufw allow 22 from 192.168.1.0/24
ufw allow 80
ufw allow 443

#Enable UFW
ufw enable

#Add a selected user to the default Apache2 group and then give that group
#ownership of the default html folder
usermod -a -G www-data $USER
chown -R -f www-data:www-data /var/www/html
chmod -R 774 /var/www/html

#Start Apache2 web server
systemctl start apache2
