#!/bin/zsh

display_ascii_art() {
    echo -e "\033[0;32m"
    cat << "EOF"
      _____             _            _       _             
     |  __ \           | |          | |     (_)            
     | |  | | ___   ___| | _____  __| | ___  _ _ __   __ _ 
     | |  | |/ _ \ / __| |/ / _ \/ _` |/ _ \| | '_ \ / _` |
     | |__| | (_) | (__|   <  __/ (_| | (_) | | | | | (_| |
     |_____/ \___/ \___|_|\_\___|\__,_|\___/|_|_| |_|\__, |
                                                     __/ |
                                                    |___/ 
EOF
    echo -e "\033[0m"
}

loading_animation() {
    local message="$1"
    local delay="${2:-0.2}"
    echo -n "$message"
    for i in {1..5}; do
        echo -n "."
        sleep "$delay"
    done
    echo ""
}

spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    echo -n " "
    while [ "$(ps a | awk '{print $1}' | grep "$pid")" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b"
    done
    echo "    "
}

progress_bar() {
    local duration=$1
    local progress=0
    local steps=20  

    echo -n "["
    for ((i = 0; i < steps; i++)); do
        echo -n " "
    done
    echo -n "]"
    tput cuu1  

    for ((i = 1; i <= steps; i++)); do
        sleep $((duration / steps))
        tput cuf $((i))
        echo -n "#"
        tput cud1 
    done
    echo
}

typing_effect() {
    local message="$1"
    local delay="${2:-0.05}"  

    for ((i = 0; i < ${#message}; i++)); do
        echo -n "${message:i:1}"
        sleep "$delay"
    done
    echo
}

matrix_animation() {
    local columns=$(tput cols)
    local lines=$(tput lines)
    local chars="abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()"

    clear
    while true; do
        for ((i = 0; i < columns; i++)); do
            local random_char="${chars:RANDOM % ${#chars}:1}"
            echo -ne "\033[32m$random_char\033[0m"
        done
        echo
        sleep 0.1
        if [[ $((RANDOM % 10)) -eq 0 ]]; then
            clear
        fi
    done
}

countdown() {
    local seconds=$1
    for ((i = seconds; i > 0; i--)); do
        echo -ne "Starting in $i seconds...\033[0K\r"
        sleep 1
    done
    echo "Starting now!"
}

spinning_dots() {
    local message="$1"
    local delay="${2:-0.2}"
    local spinstr="|/-\\"
    echo -n "$message "
    while true; do
        for ((i = 0; i < ${#spinstr}; i++)); do
            echo -ne "${spinstr:i:1}\033[0K\r"
            sleep "$delay"
        done
    done
}

export -f display_ascii_art
export -f loading_animation
export -f spinner
export -f spinning_dots
export -f matrix_animation
export -f progress_bar
export -f countdown
export -f typing_effect