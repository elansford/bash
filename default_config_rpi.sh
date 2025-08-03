# !/bin/bash

#Update existing software
apt update && apt upgrade -y
apt full-upgrade -y

#Install extra software
apt install ufw
apt install apache2

#Set basic UFW rules to be customized per box needs in the future
#I'm uing this box to host a webserver and an email server
#Your needs may vary
ufw allow 22 from 192.168.1.0/24
ufw allow 25
ufw allow 80
ufw allow 110
ufw allow 143
ufw allow 443
ufw allow 465
ufw allow 587
ufw allow 993
ufw allow 995
ufw allow 2525

#Enable UFW
ufw enable

#Add a selected user to the default Apache2 group and then give that group
#ownership of the default html folder
usermod -a -G www-data $USER
chown -R -f www-data:www-data /var/www/html
chmod -R 774 /var/www/html

#Start Apache2 web server
systemctl start apache2
