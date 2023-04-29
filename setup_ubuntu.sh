#!/bin/bash  

# Ubuntu Setup
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
> /etc/motd
echo "-----------------------------------" >> /etc/motd
echo "  _    _ _                 _         " >> /etc/motd
echo " | |  | | |               | |        " >> /etc/motd
echo " | |  | | |__  _   _ _ __ | |_ _   _ " >> /etc/motd
echo " | |  | | '_ \| | | | '_ \| __| | | |" >> /etc/motd
echo " | |__| | |_) | |_| | | | | |_| |_| |" >> /etc/motd
echo "  \____/|_.__/ \__,_|_| |_|\__|\__,_|" >> /etc/motd
echo "                                     " >> /etc/motd
echo "-----------------------------------" >> /etc/motd
echo "Ubuntu Template by Michi von Ah" >> /etc/motd
