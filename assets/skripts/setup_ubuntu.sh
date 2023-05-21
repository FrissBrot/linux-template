#!/bin/bash  

# Ubuntu Setup
# Michi von Ah - April 2023

# Run as "root"

# Install updates
apt-get update && apt-get upgrade -y

# Install basic software
apt-get install htop mc wget curl unzip ufw -y

echo done

#Variables for wolcome message
IP_ADDRESS=$(ip addr show enp0s3 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
GATEWAY=$(ip route | awk '/default/ {print $3}')
hostname=$(hostname)

# Create welcome message
> /etc/motd

echo "-----------------------------------------------" >> /etc/motd
echo "  _    _   _                       _           " >> /etc/motd
echo " | |  | | | |                     | |          " >> /etc/motd
echo " | |  | | | |__    _   _   _ __   | |_   _   _ " >> /etc/motd
echo " | |  | | | '_ \  | | | | | '_ \  | __| | | | |" >> /etc/motd
echo " | |__| | | |_) | | |_| | | | | | | |_  | |_| |" >> /etc/motd
echo "  \____/  |_.__/   \__,_| |_| |_|  \__|  \__,_|" >> /etc/motd
echo "                                               " >> /etc/motd
echo "$(lsb_release -d | awk -F"\t" '{print $2}')    " >> /etc/motd
echo "                                               " >> /etc/motd
echo "Hostname: $hostname                            " >> /etc/motd
echo "IP-Adress: $IP_ADDRESS                         " >> /etc/motd
echo "Gateway: $GATEWAY                              " >> /etc/motd
echo "-----------------------------------------------" >> /etc/motd
echo "Template by Michi von Ah & Timo Weber" >> /etc/motd


clear
cat /etc/motd

