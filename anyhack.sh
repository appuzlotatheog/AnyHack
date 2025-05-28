#!/bin/bash

# =========================
#       AnyHack v2
# =========================

# Color Codes
RED="\e[31m"
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
NC="\e[0m"

# Tool Check + Install
check_install() {
    TOOL=$1
    PKG_NAME=${2:-$TOOL}
    if ! command -v $TOOL &>/dev/null; then
        echo -e "${YELLOW}[!] $TOOL is not installed.${NC}"
        read -p "Install $PKG_NAME now? (y/n): " choice
        if [[ "$choice" == "y" ]]; then
            echo -e "${CYAN}Installing $PKG_NAME...${NC}"
            sudo apt update && sudo apt install -y "$PKG_NAME"
        else
            echo -e "${RED}Skipping $TOOL.${NC}"
            return 1
        fi
    fi
}

# ASCII Banner
clear
echo -e "${GREEN}"
cat << "EOF"
 █████╗ ███╗   ██╗██╗   ██╗██╗  ██╗ █████╗  ██████╗██╗  ██╗
██╔══██╗████╗  ██║╚██╗ ██╔╝██║  ██║██╔══██╗██╔════╝██║ ██╔╝
███████║██╔██╗ ██║ ╚████╔╝ ███████║███████║██║     █████╔╝ 
██╔══██║██║╚██╗██║  ╚██╔╝  ██╔══██║██╔══██║██║     ██╔═██╗ 
██║  ██║██║ ╚████║   ██║   ██║  ██║██║  ██║╚██████╗██║  ██╗
╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
     >>> ANYHACK - ULTIMATE HACKING TOOLKIT <<<
EOF
echo -e "${NC}"

# Categories
main_menu() {
    echo -e "${CYAN}Choose a category:${NC}"
    echo "1) Information Gathering"
    echo "2) Password Attacks"
    echo "3) Web Vulnerabilities"
    echo "4) OSINT Tools"
    echo "5) DDoS Tools"
    echo "6) Social Engineering"
    echo "7) Wireless Tools"
    echo "8) Custom Command"
    echo "0) Exit"
    read -p ">> " cat_choice
    case $cat_choice in
        1) info_gathering ;;
        2) password_attacks ;;
        3) web_vulns ;;
        4) osint_tools ;;
        5) ddos_tools ;;
        6) social_eng ;;
        7) wireless_tools ;;
        8) custom_command ;;
        0) echo -e "${GREEN}Thanks for using AnyHack!${NC}"; exit 0 ;;
        *) echo -e "${RED}Invalid option!${NC}" ;;
    esac
}

# === TOOL MENUS ===

info_gathering() {
    echo -e "${YELLOW}Information Gathering:${NC}"
    tools=("nmap" "whois" "dnsenum" "theharvester" "recon-ng" "dirb" "whatweb")
    select tool in "${tools[@]}" "Back"; do
        [[ $tool == "Back" ]] && break
        check_install "$tool" && read -p "Enter args (or leave empty): " args && $tool $args
    done
}

password_attacks() {
    echo -e "${YELLOW}Password Attacks:${NC}"
    tools=("hydra" "john" "cupp" "hashcat")
    select tool in "${tools[@]}" "Back"; do
        [[ $tool == "Back" ]] && break
        check_install "$tool" && read -p "Enter args: " args && $tool $args
    done
}

web_vulns() {
    echo -e "${YELLOW}Web Vulnerabilities:${NC}"
    tools=("nikto" "wpscan" "sqlmap" "burpsuite")
    select tool in "${tools[@]}" "Back"; do
        [[ $tool == "Back" ]] && break
        check_install "$tool" && read -p "Enter args: " args && $tool $args
    done
}

osint_tools() {
    echo -e "${YELLOW}OSINT Tools:${NC}"
    tools=("theharvester" "recon-ng" "shodan" "maltego")
    select tool in "${tools[@]}" "Back"; do
        [[ $tool == "Back" ]] && break
        if [[ $tool == "shodan" ]]; then
            check_install shodan || pip install --user shodan && shodan init
        fi
        check_install "$tool" && read -p "Enter args: " args && $tool $args
    done
}

ddos_tools() {
    echo -e "${YELLOW}DDoS Tools:${NC}"
    tools=("hping3" "slowloris" "ncat")
    select tool in "${tools[@]}" "Back"; do
        [[ $tool == "Back" ]] && break
        if [[ $tool == "slowloris" ]]; then
            git clone https://github.com/gkbrk/slowloris && cd slowloris && python3 slowloris.py
        else
            check_install "$tool" && read -p "Enter args: " args && $tool $args
        fi
    done
}

social_eng() {
    echo -e "${YELLOW}Social Engineering:${NC}"
    tools=("set")
    select tool in "${tools[@]}" "Back"; do
        [[ $tool == "Back" ]] && break
        check_install "$tool" && sudo "$tool"
    done
}

wireless_tools() {
    echo -e "${YELLOW}Wireless Attacks:${NC}"
    tools=("aircrack-ng" "wash" "reaver" "wifite")
    select tool in "${tools[@]}" "Back"; do
        [[ $tool == "Back" ]] && break
        check_install "$tool" && read -p "Enter args: " args && $tool $args
    done
}

custom_command() {
    echo -e "${CYAN}Enter any tool and command to run:${NC}"
    read -p "Tool: " tool
    check_install "$tool" && read -p "Arguments: " args && $tool $args
}

# Loop
while true; do
    main_menu
    echo ""
done
