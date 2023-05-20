#!/bin/bash

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
setup_ubuntu() {
    # Überprüfen, ob Docker-Installation ausgewählt wurde
    if [ "${selected[0]}" = "true" ]; then

        # Installiere Docker
        echo docker
        apt-get install docker.io docker-compose -y
    fi

    # Überprüfen, ob SLUZ-Zertifikat-Installation ausgewählt wurde
    if [ "${selected[1]}" = "true" ]; then
        # Installiere SLUZ-Zertifikat
        echo "Installiere SLUZ-Zertifikat"
        cd /usr/local/share/ca-certificates/
        wget https://download.lu.ch/sai/sluz_root_ca.crt
        update-ca-certificates
    fi

    # Führe setup_ubuntu.sh aus
    cd assets/skripts/
    chmod 777 setup_ubuntu.sh
    ./setup_ubuntu.sh
}


#!/bin/bash

# Betriebssystem auslesen
os=$(uname -s)

# Prüfen, ob es sich um ein Ubuntu-System handelt
if [ "$os" == "Linux" ] && [ -f "/usr/bin/apt" ]; then
    echo "Das Betriebssystem wurde als Ubuntu identifiziert und wird jetzt konfiguriert."
    setup_ubuntu
# Prüfen, ob es sich um ein Debian-System handelt
elif [ "$os" == "Linux" ] && [ -f "/usr/bin/apt-get" ]; then
    echo "Das Betriebssystem Debian wurde erkannt und wird konfiguriert."
# Ansonsten Betriebssystem nicht erkannt
else
    echo "Error: Dieses Betriebssystem wird nicht unterstütz."
    ./assets/skripts/setup_debian.sh
fi
exit