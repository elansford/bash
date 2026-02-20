# !/bin/bash

#Update existing software
apt update && apt upgrade -y
apt full-upgrade -y

#Install extra software
apt install ufw
apt install openssh-server -y
apt install curl

#Set basic UFW rules to be customized per box needs in the future
#Replace $YOUR_LOCAL_SUBNET with the proper CIDR notation for your home network
#Only TCP is allowed since none of the serivces use UDP under
#the Principle of Least Privilege
#I'm using this box to host a jellyfin server
#Your needs may vary

sudo ufw allow proto tcp from $YOUR_LOCAL_SUBNET to any port 22
sudo ufw allow proto tcp from any to any port 23
sudo ufw allow proto tcp from any to any port 80
sudo ufw allow proto tcp from any to any port 443
sudo ufw allow proto tcp from any to any port 7359
sudo ufw allow proto tcp from any to any port 8096
sudo ufw allow proto tcp from any to any port 8920

#Enable UFW and SSH
systemctl enable ssh
systemctl start ssh
ufw enable
