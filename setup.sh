#!/bin/bash

# Setup
# Timo Weber - Mai 2023

#check root permissons
if [[ $EUID -ne 0 ]]; then
  echo "Dieses Skript muss als Root ausgeführt werden. Bitte verwenden Sie 'sudo' oder führen Sie es als Root aus."
  exit 1
fi

#define options for menu
options=("install docker" "install sluz certificate" "Option 3" "Exit")

#initialize array for selectet options
selected=()
for ((i=0; i<${#options[@]}; i++)); do
    selected+=(false)
done

show_menu() {
    clear
    echo "=== SLCT Menu ==="
    for ((i=0; i<${#options[@]}; i++)); do
        if [[ ${selected[$i]} == "true" ]]; then
            echo "$((i+1)). [x] ${options[$i]}"
        else
            echo "$((i+1)). [ ] ${options[$i]}"
        fi
    done
}

process_option() {
    if [[ $1 -ge 1 && $1 -le ${#options[@]} ]]; then
        option_index=$((choice-1))
        
        if [[ ${selected[$option_index]} == "true" ]]; then
            selected[$option_index]="false"
        else
            selected[$option_index]="true"
        fi
    else
        echo "Ungültige Option. Bitte wähle eine gültige Option aus."
    fi
}

while true; do
    show_menu
    read -p "Wähle eine Option (Nummer) oder drücke Enter zum Bestätigen: " choice
    
    if [ -z "$choice" ]; then
        break
    fi
    
    # Überprüfe, ob mehrere Optionen ausgewählt wurden
    if [[ $choice =~ ^[0-9]+$ && $choice -ge 10 ]]; then
        choices=($(echo "$choice" | grep -o .))
        for ch in "${choices[@]}"; do
            process_option "$ch"
        done
    else
        process_option "$choice"
    fi
    
    echo
done

echo "Du hast folgende Optionen ausgewählt:"
for ((i=0; i<${#options[@]}; i++)); do
    if [ "${selected[$i]}" = "true" ]; then
        echo "- ${options[$i]}"
    fi
done


#functions for OS configuration
setup(){
    
    # Install updates
    apt-get update && apt-get upgrade -y

    # Install basic software
    apt-get install htop mc wget curl unzip ufw -y

    # Überprüfen, ob Docker-Installation ausgewählt wurde
    if [ "${selected[0]}" = "true" ]; then

        # Installiere Docker
        apt-get install docker.io docker-compose -y
    fi

    # Überprüfen, ob SLUZ-Zertifikat-Installation ausgewählt wurde
    if [ "${selected[1]}" = "true" ]; then
        # Installiere SLUZ-Zertifikat
        echo "Installiere SLUZ-Zertifikat"
        cd /usr/local/share/ca-certificates/
        wget https://download.lu.ch/sai/sluz_root_ca.crt
        update-ca-certificates
        cd -
    fi

    #move do skripts directory
    cd assets/skripts

    #switch to start the right conig skript
    case $1 in

        ubuntu)
            configure_ubuntu
            ;;

        debian)
            configure_debian
            ;;

        *)
            echo exit
            exit
            ;;

    esac
}

configure_ubuntu() {
    # start config_ubuntu.sh
    sudo chmod 777 config_ubuntu.sh
    ./config_ubuntu.sh
}

configure_debian(){
     # start config_debian.sh
    sudo chmod 777 config_debian.sh
    ./config_debian.sh
}


# Betriebssystem auslesen
os=$(uname -s)

# Prüfen, ob es sich um ein Ubuntu-System handelt
if [ "$os" == "Linux" ] && [ -f "/usr/bin/apt" ]; then
    echo -e "Das Betriebssystem wurde als \e[92mUbuntu\e[0m identifiziert und wird jetzt konfiguriert."
    setup "ubuntu"
# Prüfen, ob es sich um ein Debian-System handelt
elif [ "$os" == "Linux" ] && [ -f "/usr/bin/apt-get" ]; then
    echo "Das Betriebssystem wurde als \e[92mDebian\e[0m identifiziert und wird jetzt konfiguriert."
    setup "debian"
# Ansonsten Betriebssystem nicht erkannt
else
    echo "Error: Dieses Betriebssystem wird nicht unterstütz."
    exit
fi
exit