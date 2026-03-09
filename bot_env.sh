#!/bin/bash

# ============================================
#        ARCHON - Bot Environment Setup
# ============================================

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m'

print_step() { echo -e "${GREEN}[BOT ENV]${NC} ${WHITE}$1${NC}"; }
print_success() { echo -e "${GREEN}[✓]${NC} $1"; }

echo -e "${CYAN}Setting up Bot Environment...${NC}"
echo ""

# Python setup
print_step "Installing Python & pip packages..."
sudo apt install -y python3 python3-pip python3-venv
pip3 install --break-system-packages \
    requests \
    aiohttp \
    discord.py \
    python-telegram-bot \
    tweepy \
    selenium \
    beautifulsoup4 \
    flask \
    fastapi \
    uvicorn
print_success "Python bot packages installed!"

# Node.js setup
print_step "Installing Node.js & npm packages..."
sudo apt install -y nodejs npm
npm install -g \
    discord.js \
    telegraf \
    axios \
    express \
    pm2
print_success "Node.js bot packages installed!"

# PM2 for process management
print_step "Setting up PM2 process manager..."
npm install -g pm2
print_success "PM2 installed! Use 'pm2 start yourbot.js' to run bots persistently"

echo ""
echo -e "${YELLOW}Bot Environment Ready!${NC}"
echo ""
echo -e "${WHITE}Quick commands:${NC}"
echo -e "  ${CYAN}Python bot:${NC}  screen -S mybot python3 bot.py"
echo -e "  ${CYAN}Node bot:${NC}    pm2 start bot.js --name mybot"
echo -e "  ${CYAN}View logs:${NC}   pm2 logs mybot"
echo -e "  ${CYAN}Stop bot:${NC}    pm2 stop mybot"
echo ""
print_success "Bot environment setup complete!"
