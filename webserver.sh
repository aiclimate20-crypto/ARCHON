#!/bin/bash

# ============================================
#        ARCHON - Web Server Setup
# ============================================

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m'

print_step() { echo -e "${GREEN}[WEBSERVER]${NC} ${WHITE}$1${NC}"; }
print_success() { echo -e "${GREEN}[✓]${NC} $1"; }

echo -e "${CYAN}Setting up Web Server...${NC}"
echo ""
echo -e "${YELLOW}Choose web server:${NC}"
echo ""
echo -e "  ${WHITE}1)${NC} Nginx (Recommended)"
echo -e "  ${WHITE}2)${NC} Apache"
echo -e "  ${WHITE}3)${NC} Node.js Express"
echo -e "  ${WHITE}4)${NC} Python HTTP Server"
echo ""
read -p "$(echo -e ${YELLOW}Enter choice [1-4]: ${NC})" ws_choice

case $ws_choice in
    1)
        print_step "Installing Nginx..."
        sudo apt install nginx -y
        sudo service nginx start
        print_success "Nginx installed and running on port 80!"
        echo -e "${CYAN}Web root: /var/www/html${NC}"
        ;;
    2)
        print_step "Installing Apache..."
        sudo apt install apache2 -y
        sudo service apache2 start
        print_success "Apache installed and running on port 80!"
        echo -e "${CYAN}Web root: /var/www/html${NC}"
        ;;
    3)
        print_step "Setting up Node.js Express server..."
        sudo apt install nodejs npm -y
        mkdir -p ~/archon-web
        cd ~/archon-web
        npm init -y
        npm install express
        cat > server.js << 'EOF'
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.send('<h1>ARCHON Web Server</h1><p>Your server is running!</p>');
});

app.listen(PORT, () => {
    console.log(`ARCHON server running on port ${PORT}`);
});
EOF
        screen -dmS webserver node server.js
        print_success "Node.js Express server running on port 3000!"
        ;;
    4)
        print_step "Starting Python HTTP Server..."
        mkdir -p ~/archon-web
        cd ~/archon-web
        echo "<h1>ARCHON Web Server</h1><p>Running on Python!</p>" > index.html
        screen -dmS webserver python3 -m http.server 8080
        print_success "Python server running on port 8080!"
        ;;
esac

echo ""
print_success "Web server setup complete!"
echo -e "${CYAN}Use Cloudflare tunnel to make it public!${NC}"
