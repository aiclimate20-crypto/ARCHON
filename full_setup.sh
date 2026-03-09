#!/bin/bash

# ============================================
#        ARCHON - Full Setup Script
# ============================================

GREEN='\033[0;32m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

print_step() { echo -e "${GREEN}[ARCHON]${NC} ${WHITE}$1${NC}"; }
print_success() { echo -e "${GREEN}[✓]${NC} $1"; }

echo -e "${CYAN}Starting ARCHON Full Setup...${NC}"
echo ""

# Step 1 - Update system
print_step "Updating system packages..."
sudo apt update -y && sudo apt upgrade -y
print_success "System updated!"

# Step 2 - Install essential tools
print_step "Installing essential tools..."
sudo apt install -y \
    curl wget git unzip zip \
    screen tmux htop neofetch \
    net-tools nmap \
    python3 python3-pip \
    nodejs npm \
    nginx \
    default-jdk \
    ufw \
    build-essential
print_success "Essential tools installed!"

# Step 3 - Install Cloudflare tunnel
print_step "Installing Cloudflare Tunnel..."
bash scripts/cloudflare.sh
print_success "Cloudflare installed!"

# Step 4 - Setup web server
print_step "Setting up Nginx web server..."
bash scripts/webserver.sh
print_success "Web server ready!"

# Step 5 - Bot environment
print_step "Setting up Bot environment..."
bash scripts/bot_env.sh
print_success "Bot environment ready!"

# Step 6 - Keep alive
print_step "Setting up Keep Alive..."
bash scripts/keepalive.sh
print_success "Keep alive activated!"

# Step 7 - Launch panel
print_step "Launching ARCHON Panel..."
sleep 2
bash scripts/panel.sh
