#!/bin/bash

options=("install docker" "install sluz certificate" "Option 3" "Exit")
selected=()

show_menu() {
    clear
    echo "=== Mein Auswahlmenü ==="
    for ((i=0; i<${#options[@]}; i++)); do
        if [[ " ${selected[*]} " == *" ${options[$i]} "* ]]; then
            echo "$((i+1)). [x] ${options[$i]}"
        else
            echo "$((i+1)). [ ] ${options[$i]}"
        fi
    done
}

process_option() {
    if [[ $1 -ge 1 && $1 -le ${#options[@]} ]]; then
        option_index=$((choice-1))
        option="${options[$option_index]}"
        
        if [[ " ${selected[*]} " == *" $option "* ]]; then
            selected=("${selected[@]/$option}")
        else
            selected+=("$option")
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
for ((i=0; i<${#selected[@]}; i++)); do
    echo "- ${selected[$i]}"
done


#functions for OS configuration
setup_ubuntu() {
    cd assets/skripts/
    sudo chmod 777 setup_ubuntu.sh
    ./setup_ubuntu.sh

    #check if docker install was selectet
    if [ ${#selected[0]} -gt 0 ]; then
       # Install docker
        apt-get install docker.io docker-compose -y 
    fi

        if [ ${#selected[1]} -gt 0 ]; then
       # Install slz certificate
        apt-get install docker.io docker-compose -y 
    fi
}

#!/bin/bash

# Betriebssystem auslesen
os=$(uname -s)

# Prüfen, ob es sich um ein Ubuntu-System handelt
if [ "$os" == "Linux" ] && [ -f "/usr/bin/apt" ]; then
    echo "Das Betriebssystem Ubuntu wurde erkannt und wird konfiguriert."
    echo "Array: ${selected[1]}"
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