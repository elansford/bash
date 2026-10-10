# !/bin/bash

#This script is intended to be run to configure a Pi-hole server
#after running 'basic_config.sh' script. It will update the system,
#and install Pi-hole

#Update existing software
sudo apt update && apt upgrade -y
sudo apt full-upgrade -y

#Install extra software
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