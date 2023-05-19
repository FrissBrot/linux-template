#!/bin/bash

# Array mit Menüoptionen
options=("install sluz" "enable ssh root login" "install docker" "Exit")

# Array zum Speichern der ausgewählten Optionen
selected=()

# Funktion zur Anzeige des Menüs
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

# Funktion zur Verarbeitung der ausgewählten Option
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

# Hauptschleife des Skripts
while true; do
    show_menu
    read -p "Wähle eine Option (Nummer) und drücke Enter zum Bestätigen: " choice
    
    if [ -z "$choice" ]; then
        break
    fi
    
    process_option $choice
    echo
done

echo "Du hast folgende Optionen ausgewählt:"
for ((i=0; i<${#selected[@]}; i++)); do
    echo "- ${selected[$i]}"
done
