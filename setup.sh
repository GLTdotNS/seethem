#!/bin/bash

# Console colors using tput
red_color=$(tput setaf 1)
violet=$(tput setaf 125)
reset_color=$(tput sgr0)

pattern=$(cat <<-END

███████ ███████ ███████ ████████ ██   ██ ███████ ███    ███  █████  ██      ██
██      ██      ██         ██    ██   ██ ██      ████  ████ ██   ██ ██      ██
███████ █████   █████      ██    ███████ █████   ██ ████ ██ ███████ ██      ██
     ██ ██      ██         ██    ██   ██ ██      ██  ██  ██ ██   ██ ██      ██
███████ ███████ ███████    ██    ██   ██ ███████ ██      ██ ██   ██ ███████ ███████

END
)

info="This app aims to scan your private network. The commands are listed below"
version="                v1.0"

# Function to check dependencies
function check_dependencies() {
    echo "Checking dependencies..."

    # Check for Python 3
    if ! command -v python3 &> /dev/null; then
        echo "Python3 not found. Installing..."
        sudo apt-get update
        sudo apt-get install -y python3
    fi

    # Check if pip (Python package manager) is installed
    if ! command -v pip3 &> /dev/null; then
        echo "pip3 not found. Installing..."
        sudo apt-get install -y python3-pip
    fi

    # Install required Python packages from requirements.txt
    requirements_file="/home/$(whoami)/PycharmProjects/seethem/requirements.txt"
    if [ -f "$requirements_file" ]; then
        echo "Installing Python dependencies..."
        sudo pip3 install -r "$requirements_file"
    else
        echo "requirements.txt not found. Make sure it exists in the project directory."
    fi
}

# Function to install tput if missing
function install_tput() {
    if ! command -v tput &> /dev/null; then
        echo "tput not found. Installing..."
        sudo apt-get install -y ncurses-bin
    fi
}

# Function to start the main Python script
function START_SCRIPT() {
    (cd /home/$(whoami)/PycharmProjects/seethem/ && python3 main.py --scan)
}

# Function to start Kicker
function Kicker() {
    (cd /home/$(whoami)/PycharmProjects/seethem/Kicker/ && sudo python3 Kicker.py)
}

# Function to perform a stealth scan
function stealth_scan() {
    (cd /home/$(whoami)/PycharmProjects/seethem/ && python3 main.py --stealth-scan)
}

# Function to hunt for specific devices
function hunt_device() {
    echo "Enter MAC address prefix to hunt (e.g., '00:1A:2B'): "
    read -r mac_prefix
    (cd /home/$(whoami)/PycharmProjects/seethem/ && python3 main.py --hunt-device "$mac_prefix")
}

# Function to log results
function log_results() {
    echo "Choose format to save results (text/json): "
    read -r format
    (cd /home/$(whoami)/PycharmProjects/seethem/ && python3 main.py --log-results "$format")
}

# Function to perform passive sniffing
function passive_sniffing() {
    echo "Enter network interface to listen on (e.g., 'eth0'): "
    read -r interface
    (cd /home/$(whoami)/PycharmProjects/seethem/ && python3 main.py --passive-sniffing "$interface")
}

# Function to send notifications
function send_notification() {
    echo "Enter the email address for notifications: "
    read -r email
    (cd /home/$(whoami)/PycharmProjects/seethem/ && python3 main.py --notify "$email")
}

# Function to compare with historical data
function compare_history() {
    (cd /home/$(whoami)/PycharmProjects/seethem/ && python3 main.py --compare-history)
}

# Dependency and environment setup
check_dependencies
install_tput

# Display the menu
echo "${red_color}${pattern}"
echo "${reset_color}${version}"
echo "${info}"
echo ""
echo "${violet}>> --scan = scan online hosts on your network."
echo ">> --stealth-scan = perform a stealth scan."
echo ">> --hunt-device = hunt for specific devices."
echo ">> --log-results = save scan results to a file."
echo ">> --passive-sniffing = perform passive network sniffing."
echo ">> --notify = send notifications to an email address."
echo ">> --compare-history = compare current scan with previous scans."
echo ">> --kick = kick devices from the network."
echo ">> --exit = exit app. ${reset_color}"

# Read the user's command
printf "Enter the command ==> "
read -r answer

# Main loop for handling commands
while [ "$answer" != "--exit" ]; do

    case "$answer" in
        --scan)
            echo ""
            sleep 2
            START_SCRIPT
            ;;
        --stealth-scan)
            stealth_scan
            ;;
        --hunt-device)
            hunt_device
            ;;
        --log-results)
            log_results
            ;;
        --passive-sniffing)
            passive_sniffing
            ;;
        --notify)
            send_notification
            ;;
        --compare-history)
            compare_history
            ;;
        --kick)
            Kicker
            ;;
        *)
            echo "Unknown command"
            ;;
    esac

    printf "${reset_color}Enter the command ==> "
    read -r answer
done
