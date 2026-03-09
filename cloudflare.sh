#!/bin/bash

# ============================================
#        ARCHON - Cloudflare Tunnel Setup
# ============================================

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
RED='\033[0;31m'
NC='\033[0m'

print_step() { echo -e "${GREEN}[CLOUDFLARE]${NC} ${WHITE}$1${NC}"; }
print_success() { echo -e "${GREEN}[✓]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

echo -e "${CYAN}Setting up Cloudflare Tunnel...${NC}"
echo ""

# Download cloudflared
print_step "Downloading cloudflared..."
wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb -O /tmp/cloudflared.deb

# Install
print_step "Installing cloudflared..."
sudo dpkg -i /tmp/cloudflared.deb
rm /tmp/cloudflared.deb

# Verify install
if command -v cloudflared &> /dev/null; then
    print_success "Cloudflare tunnel installed! Version: $(cloudflared --version)"
else
    print_error "Installation failed!"
    exit 1
fi

echo ""
echo -e "${YELLOW}Choose Cloudflare Tunnel mode:${NC}"
echo ""
echo -e "  ${WHITE}1)${NC} Quick Tunnel (No account needed - temporary URL)"
echo -e "  ${WHITE}2)${NC} Named Tunnel (Cloudflare account required - permanent URL)"
echo ""
read -p "$(echo -e ${YELLOW}Enter choice [1-2]: ${NC})" cf_choice

case $cf_choice in
    1)
        echo ""
        print_step "Starting Quick Tunnel..."
        echo -e "${YELLOW}Enter the port your service runs on (default: 80):${NC}"
        read -p "Port: " port
        port=${port:-80}
        echo ""
        echo -e "${GREEN}Starting tunnel on port $port...${NC}"
        echo -e "${YELLOW}Your public URL will appear below:${NC}"
        echo ""
        screen -dmS cf_tunnel cloudflared tunnel --url http://localhost:$port
        sleep 3
        print_success "Tunnel started in background screen session 'cf_tunnel'"
        echo -e "${CYAN}Run: screen -r cf_tunnel  to see your URL${NC}"
        ;;
    2)
        echo ""
        print_step "Logging into Cloudflare..."
        cloudflared tunnel login
        echo ""
        read -p "$(echo -e ${YELLOW}Enter tunnel name: ${NC})" tunnel_name
        cloudflared tunnel create $tunnel_name
        print_success "Named tunnel '$tunnel_name' created!"
        echo -e "${CYAN}Check config/ folder for tunnel config${NC}"
        ;;
    *)
        print_error "Invalid choice"
        ;;
esac

echo ""
print_success "Cloudflare setup complete!"
