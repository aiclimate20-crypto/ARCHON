#!/bin/bash

# ============================================
#        ARCHON VPS INSTALLER v1.0
#        Made by Nomaan (FADE)
#        Free VPS Setup for Firebase IDX
# ============================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

clear

echo -e "${CYAN}"
echo "  ░█████╗░██████╗░░█████╗░██╗░░██╗░█████╗░███╗░░██╗"
echo "  ██╔══██╗██╔══██╗██╔══██╗██║░░██║██╔══██╗████╗░██║"
echo "  ███████║██████╔╝██║░░╚═╝███████║██║░░██║██╔██╗██║"
echo "  ██╔══██║██╔══██╗██║░░██╗██╔══██║██║░░██║██║╚████║"
echo "  ██║░░██║██║░░██║╚█████╔╝██║░░██║╚█████╔╝██║░╚███║"
echo "  ╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝"
echo -e "${NC}"
echo -e "${WHITE}         Free VPS Setup for Firebase IDX${NC}"
echo -e "${YELLOW}              Made by Nomaan (FADE)${NC}"
echo ""
echo -e "${BLUE}================================================${NC}"
echo ""

# Functions
print_step() {
    echo -e "${GREEN}[ARCHON]${NC} ${WHITE}$1${NC}"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

# Check if running in IDX
print_step "Checking environment..."
if [ -d "/home/user" ] || [ "$CLOUDENV_ENVIRONMENT_ID" != "" ]; then
    print_success "Firebase IDX environment detected!"
else
    print_warning "Not detected as IDX but continuing anyway..."
fi

echo ""
echo -e "${CYAN}What would you like to install?${NC}"
echo ""
echo -e "  ${WHITE}1)${NC} Full Setup (Recommended)"
echo -e "  ${WHITE}2)${NC} Cloudflare Tunnel Only"
echo -e "  ${WHITE}3)${NC} Web Server (Nginx)"
echo -e "  ${WHITE}4)${NC} Bot Environment (Python + Node.js)"
echo -e "  ${WHITE}5)${NC} Game Server (Minecraft)"
echo -e "  ${WHITE}6)${NC} ARCHON Panel (Terminal Dashboard)"
echo -e "  ${WHITE}7)${NC} Keep Alive Script"
echo -e "  ${WHITE}0)${NC} Exit"
echo ""
read -p "$(echo -e ${YELLOW}Enter choice [0-7]: ${NC})" choice

case $choice in
    1) bash scripts/full_setup.sh ;;
    2) bash scripts/cloudflare.sh ;;
    3) bash scripts/webserver.sh ;;
    4) bash scripts/bot_env.sh ;;
    5) bash scripts/gameserver.sh ;;
    6) bash scripts/panel.sh ;;
    7) bash scripts/keepalive.sh ;;
    0) echo -e "${RED}Exiting ARCHON...${NC}"; exit 0 ;;
    *) print_error "Invalid choice!"; bash install.sh ;;
esac
