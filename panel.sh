#!/bin/bash

# ============================================
#        ARCHON - Terminal Panel Dashboard
# ============================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

show_panel() {
    clear
    echo -e "${CYAN}"
    echo "  ░█████╗░██████╗░░█████╗░██╗░░██╗░█████╗░███╗░░██╗"
    echo "  ██╔══██╗██╔══██╗██╔══██╗██║░░██║██╔══██╗████╗░██║"
    echo "  ███████║██████╔╝██║░░╚═╝███████║██║░░██║██╔██╗██║"
    echo "  ██╔══██║██╔══██╗██║░░██╗██╔══██║██║░░██║██║╚████║"
    echo "  ██║░░██║██║░░██║╚█████╔╝██║░░██║╚█████╔╝██║░╚███║"
    echo "  ╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝"
    echo -e "${NC}"
    echo -e "${WHITE}          Terminal Panel v1.0 by Nomaan (FADE)${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════${NC}"

    # System Info
    echo ""
    echo -e "${YELLOW}  ⚡ SYSTEM INFO${NC}"
    echo -e "  ${WHITE}OS:${NC}      $(uname -o) $(uname -r)"
    echo -e "  ${WHITE}Host:${NC}    $(hostname)"
    echo -e "  ${WHITE}Uptime:${NC}  $(uptime -p)"

    # CPU
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    CPU_CORES=$(nproc)
    echo -e "  ${WHITE}CPU:${NC}     ${CPU_USAGE}% used | ${CPU_CORES} cores"

    # RAM
    RAM_TOTAL=$(free -m | awk '/^Mem:/{print $2}')
    RAM_USED=$(free -m | awk '/^Mem:/{print $3}')
    RAM_FREE=$(free -m | awk '/^Mem:/{print $4}')
    echo -e "  ${WHITE}RAM:${NC}     ${RAM_USED}MB used / ${RAM_TOTAL}MB total (${RAM_FREE}MB free)"

    # DISK
    DISK_TOTAL=$(df -h / | awk 'NR==2{print $2}')
    DISK_USED=$(df -h / | awk 'NR==2{print $3}')
    DISK_FREE=$(df -h / | awk 'NR==2{print $4}')
    echo -e "  ${WHITE}DISK:${NC}    ${DISK_USED} used / ${DISK_TOTAL} total (${DISK_FREE} free)"

    echo ""
    echo -e "${BLUE}════════════════════════════════════════════════════${NC}"

    # Active Screens
    echo ""
    echo -e "${YELLOW}  🖥️  ACTIVE SESSIONS${NC}"
    SCREENS=$(screen -ls 2>/dev/null | grep -E "^\s+[0-9]+" | awk '{print $1}')
    if [ -z "$SCREENS" ]; then
        echo -e "  ${RED}No active screen sessions${NC}"
    else
        echo "$SCREENS" | while read screen; do
            echo -e "  ${GREEN}●${NC} $screen"
        done
    fi

    echo ""
    echo -e "${BLUE}════════════════════════════════════════════════════${NC}"

    # Services Status
    echo ""
    echo -e "${YELLOW}  🔧 SERVICES${NC}"

    # Check Nginx
    if service nginx status > /dev/null 2>&1; then
        echo -e "  ${GREEN}●${NC} Nginx        ${GREEN}Running${NC}"
    else
        echo -e "  ${RED}●${NC} Nginx        ${RED}Stopped${NC}"
    fi

    # Check cloudflared
    if pgrep cloudflared > /dev/null; then
        echo -e "  ${GREEN}●${NC} Cloudflare   ${GREEN}Running${NC}"
    else
        echo -e "  ${RED}●${NC} Cloudflare   ${RED}Stopped${NC}"
    fi

    # Check PM2
    if command -v pm2 &> /dev/null; then
        PM2_COUNT=$(pm2 list 2>/dev/null | grep -c "online" || echo 0)
        echo -e "  ${GREEN}●${NC} PM2 Bots     ${GREEN}${PM2_COUNT} running${NC}"
    else
        echo -e "  ${RED}●${NC} PM2          ${RED}Not installed${NC}"
    fi

    echo ""
    echo -e "${BLUE}════════════════════════════════════════════════════${NC}"

    # Menu
    echo ""
    echo -e "${YELLOW}  📋 ACTIONS${NC}"
    echo ""
    echo -e "  ${WHITE}1)${NC} Run Installer"
    echo -e "  ${WHITE}2)${NC} Start Cloudflare Tunnel"
    echo -e "  ${WHITE}3)${NC} View Screen Sessions"
    echo -e "  ${WHITE}4)${NC} Start Keep Alive"
    echo -e "  ${WHITE}5)${NC} System Monitor (htop)"
    echo -e "  ${WHITE}6)${NC} Refresh Panel"
    echo -e "  ${WHITE}0)${NC} Exit Panel"
    echo ""
    echo -e "${BLUE}════════════════════════════════════════════════════${NC}"
    echo ""
    read -p "$(echo -e ${YELLOW}  ARCHON\> ${NC})" panel_choice

    case $panel_choice in
        1) bash install.sh ;;
        2) bash scripts/cloudflare.sh ;;
        3) screen -ls; echo ""; read -p "Press Enter to continue..." ;;
        4) bash scripts/keepalive.sh ;;
        5) htop ;;
        6) show_panel ;;
        0) echo -e "${RED}Goodbye Nomaan! 👋${NC}"; exit 0 ;;
        *) show_panel ;;
    esac

    show_panel
}

show_panel
