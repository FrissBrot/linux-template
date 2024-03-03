# linux-template
My default linux config/template

Collection of some useful scripts for basic setup a new debian or ubuntu installation.

Features:
- Script for debian
- Script for ubuntu
- Addition for installing sluz certificate

## Get started
1. Install git
    ```bash
    apt-get install git -y
    ```
1. Clone Repo
    ```bash
    git clone https://github.com/FrissBrot/linux-template.git
    ```
1. Run script
    ```bash
    bash setup_debian.sh
    ```

## One line execution
1. Run command (not as root)
    ```bash
    sudo apt update && sudo apt-get install git -y && git clone https://github.com/FrissBrot/linux-template.git && sudo bash setup.sh
    ```
