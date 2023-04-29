#!/bin/bash  

# Debian Setup
# Michi von Ah - April 2023

# Run as "root"

# Install updates
apt-get update && apt-get upgrade -y

# Install basic software
apt-get install htop mc wget curl unzip ufw -y

# Install git
apt-get install git -y

# Install docker
apt-get install docker.io docker-compose -y

# Create welcome message
#sed -i "s#PrintMotd no#PrintMotd yes#g" /etc/ssh/sshd_config
> /etc/motd
echo "-----------------------------------" >> /etc/motd
echo "  _____       _     _             " >> /etc/motd
echo " |  __ \     | |   (_)            " >> /etc/motd
echo " | |  | | ___| |__  _  __ _ _ __  " >> /etc/motd
echo " | |  | |/ _ \ '_ \| |/ _\` | '_ \ " >> /etc/motd
echo " | |__| |  __/ |_) | | (_| | | | |" >> /etc/motd
echo " |_____/ \___|_.__/|_|\__,_|_| |_|" >> /etc/motd
echo "                                  " >> /etc/motd
echo "-----------------------------------" >> /etc/motd
echo "Debian Template by Michi von Ah" >> /etc/motd

#systemctl restart sshd
