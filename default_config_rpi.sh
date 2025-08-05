# !/bin/bash

#Update existing software
apt update && apt upgrade -y
apt full-upgrade -y

#Install extra software
apt install ufw
apt install apache2

#Set basic UFW rules to be customized per box needs in the future
#Replace $YOUR_LOCAL_SUBNET with the proper CIDR notation for your home network
#Only TCP is allowed since none of the serivces use UDP under
#the Principle of Least Privilege
#I'm using this box to host a webserver and an email server
#Your needs may vary

sudo ufw allow proto tcp from $YOUR_LOCAL_SUBNET to any port 22
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


#Enable UFW
ufw enable

#Add a selected user to the default Apache2 group and then give that group
#ownership of the default html folder
usermod -a -G www-data $USER
chown -R -f www-data:www-data /var/www/html
chmod -R 774 /var/www/html

#Start Apache2 web server
systemctl start apache2
