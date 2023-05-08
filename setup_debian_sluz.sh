#!/bin/bash  

# Debian Setup with SLUZ Certificate
# Michi von Ah - April 2023

# Run as "root"

# Install updates
apt-get update && apt-get upgrade -y

# Install sluz certificate
cd /usr/local/share/ca-certificates/
wget https://download.lu.ch/sai/sluz_root_ca.crt
update-ca-certificates

# Start normal setup script
#bash setup_debian.sh