#!/bin/bash  

# Debian Setup
# Michi von Ah - April 2023

# Run as "root"

# Create welcome message
# Ascii Art Generator: https://patorjk.com/software/taag/#p=display&c=echo&f=Big&t=Debian
#sed -i "s#PrintMotd no#PrintMotd yes#g" /etc/ssh/sshd_config
> /etc/motd

echo "--------------------------------------------" >> /etc/motd
echo "  _____           _       _                 " >> /etc/motd
echo " |  __ \         | |     (_)                " >> /etc/motd
echo " | |  | |   ___  | |__    _    __ _   _ __  " >> /etc/motd
echo " | |  | |  / _ \ | '_ \  | |  / _\` | | '_ \ " >> /etc/motd
echo " | |__| | |  __/ | |_) | | | | (_| | | | | |" >> /etc/motd
echo " |_____/   \___| |_.__/  |_|  \__,_| |_| |_|" >> /etc/motd
echo "                                            " >> /etc/motd
echo "$(lsb_release -d | awk -F"\t" '{print $2}')" >> /etc/motd
echo "--------------------------------------------" >> /etc/motd
echo "Template by Michi von Ah & Timo Weber" >> /etc/motd

#systemctl restart sshd
