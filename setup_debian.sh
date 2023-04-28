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