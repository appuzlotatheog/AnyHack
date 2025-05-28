#!/bin/bash

# Color Codes
RED="\e[31m"
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
NC="\e[0m" # No Color

# Check & install a tool if missing
check_install() {
    TOOL=$1
    PKG_NAME=${2:-$TOOL}

    if ! command -v $TOOL &> /dev/null; then
        echo -e "${YELLOW}[!] $TOOL is not installed.${NC}"
        read -p "Install $PKG_NAME now? (y/n): " choice
        if [[ $choice == "y" ]]; then
            echo -e "${CYAN}Installing $PKG_NAME...${NC}"
            sudo apt update && sudo apt install -y $PKG_NAME
        else
            echo -e "${RED}Skipping $TOOL.${NC}"
            return 1
        fi
    fi
}

# ASCII Banner
clear
echo -e "${GREEN}"
echo "         █████╗ ███╗   ██╗██╗   ██╗██╗  ██╗ █████╗  ██████╗██╗  ██╗"
echo "        ██╔══██╗████╗  ██║╚██╗ ██╔╝██║  ██║██╔══██╗██╔════╝██║ ██╔╝"
echo "        ███████║██╔██╗ ██║ ╚████╔╝ ███████║███████║██║     █████╔╝ "
echo "        ██╔══██║██║╚██╗██║  ╚██╔╝  ██╔══██║██╔══██║██║     ██╔═██╗ "
echo "        ██║  ██║██║ ╚████║   ██║   ██║  ██║██║  ██║╚██████╗██║  ██╗"
echo "        ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝"
echo -e "           ${CYAN}>> ANYHACK - Pentesting Toolkit <<${NC}\n"

# Main Menu
while true; do
    echo -e "${CYAN}Choose a category:${NC}"
    echo "1) Information Gathering"
    echo "2) Password Attacks"
    echo "3) Web Vulnerabilities"
    echo "4) OSINT Tools"
    echo "5) DDoS Tools"
    echo "6) Social Engineering"
    echo "0) Exit"
    read -p ">> " cat_choice

    case $cat_choice in
        1)
            echo -e "${YELLOW}Information Gathering Tools:${NC}"
            echo "1) nmap"
            echo "2) whois"
            echo "3) dnsenum"
            echo "4) theHarvester"
            echo "5) recon-ng"
            read -p "Select tool: " tool
            case $tool in
                1) check_install nmap && read -p "Target IP: " ip && nmap -sV \$ip ;;
                2) check_install whois && read -p "Domain: " dom && whois \$dom ;;
                3) check_install dnsenum && read -p "Domain: " dom && dnsenum \$dom ;;
                4) check_install theharvester && theharvester ;;
                5) check_install recon-ng && recon-ng ;;
            esac
            ;;
        2)
            echo -e "${YELLOW}Password Attack Tools:${NC}"
            echo "1) hydra"
            echo "2) john"
            echo "3) cupp"
            read -p "Select tool: " tool
            case $tool in
                1) check_install hydra && hydra ;;
                2) check_install john && john ;;
                3) check_install cupp && cupp ;;
            esac
            ;;
        3)
            echo -e "${YELLOW}Web Vulnerability Tools:${NC}"
            echo "1) nikto"
            echo "2) wpscan"
            echo "3) sqlmap"
            echo "4) metasploit-framework"
            read -p "Select tool: " tool
            case $tool in
                1) check_install nikto && read -p "Target URL: " url && nikto -h \$url ;;
                2) check_install wpscan && wpscan ;;
                3) check_install sqlmap && sqlmap ;;
                4) check_install msfconsole metasploit-framework && msfconsole ;;
            esac
            ;;
        4)
            echo -e "${YELLOW}OSINT Tools:${NC}"
            echo "1) theHarvester"
            echo "2) recon-ng"
            echo "3) shodan (CLI)"
            read -p "Select tool: " tool
            case $tool in
                1) check_install theharvester && theharvester ;;
                2) check_install recon-ng && recon-ng ;;
                3) check_install shodan || pip install --user shodan && shodan ;;
            esac
            ;;
        5)
            echo -e "${YELLOW}DDoS Tools:${NC}"
            echo "1) hping3"
            echo "2) slowloris (Python)"
            read -p "Select tool: " tool
            case $tool in
                1) check_install hping3 && hping3 ;;
                2) check_install python3 && git clone https://github.com/gkbrk/slowloris && cd slowloris && python3 slowloris.py ;;
            esac
            ;;
        6)
            echo -e "${YELLOW}Social Engineering Tools:${NC}"
            echo "1) Social-Engineer Toolkit (SET)"
            read -p "Select tool: " tool
            case $tool in
                1) check_install set set && sudo set ;;
            esac
            ;;
        0)
            echo -e "${GREEN}Thanks for using AnyHack!${NC}"
            exit 0
            ;;
        *) echo -e "${RED}Invalid choice.${NC}" ;;
    esac

echo -e "\n"
done
