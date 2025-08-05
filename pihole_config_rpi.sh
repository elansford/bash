# !/bin/bash

#Update existing software
apt update && apt upgrade -y
apt full-upgrade -y

#Install extra software
apt install ufw
curl -sSL https://install.pi-hole.net | bash

#Set basic block lists
#I've found these to work well for me. They block about 20% of total traffic on my network. Most streaming services are ad free now,
#even though I don't pay for premium. This will disable ad-based powerups/bonuses on most tablet and phone games.
sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts', 1, 'Steven Black Master');"
sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('https://raw.githubusercontent.com/laylavish/uBlockOrigin-HUGE-AI-Blocklist/main/noai_hosts.txt', 1, 'laylavish');"
sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('https://raw.githubusercontent.com/StevenBlack/hosts/master/extensions/fakenews/hosts', 1, 'Steven Black Fake News');"
sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('https://perflyst.github.io/PiHoleBlocklist/AmazonFireTV.txt', 1, '');"
sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('https://perflyst.github.io/PiHoleBlocklist/SessionReplay.txt', 1, '');"
sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV.txt', 1, '');"
sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('https://perflyst.github.io/PiHoleBlocklist/android-tracking.txt', 1, 'Android Tracking');"
pihole -g

#Set basic UFW rules to be customized per box needs in the future
#Replace $YOUR_LOCAL_SUBNET with your network information in CIDR notation
sudo ufw allow proto tcp from $YOUR_LOCAL_SUBNET to any port 22
ufw allow 53
ufw allow 80
ufw allow 443

#Start new services
ufw enable
