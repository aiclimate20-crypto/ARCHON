#!/bin/bash

# ============================================
#        ARCHON - Game Server Setup
# ============================================

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m'

print_step() { echo -e "${GREEN}[GAME SERVER]${NC} ${WHITE}$1${NC}"; }
print_success() { echo -e "${GREEN}[✓]${NC} $1"; }

echo -e "${CYAN}Setting up Game Server...${NC}"
echo ""
echo -e "${YELLOW}Choose game server:${NC}"
echo ""
echo -e "  ${WHITE}1)${NC} Minecraft Java Edition"
echo -e "  ${WHITE}2)${NC} Minecraft Bedrock Edition"
echo -e "  ${WHITE}3)${NC} Terraria"
echo -e "  ${WHITE}4)${NC} CS:GO / CS2 (SRCDS)"
echo ""
read -p "$(echo -e ${YELLOW}Enter choice [1-4]: ${NC})" game_choice

case $game_choice in
    1)
        print_step "Setting up Minecraft Java Server..."
        sudo apt install -y default-jdk wget
        mkdir -p ~/archon-minecraft
        cd ~/archon-minecraft

        echo -e "${YELLOW}Choose Minecraft version:${NC}"
        echo "  1) Latest (1.21)"
        echo "  2) 1.20.4"
        echo "  3) 1.19.4"
        read -p "Version choice: " mc_ver

        case $mc_ver in
            1) MC_URL="https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar" ;;
            2) MC_URL="https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar" ;;
            3) MC_URL="https://piston-data.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar" ;;
        esac

        wget -q $MC_URL -O server.jar
        echo "eula=true" > eula.txt

        cat > start.sh << 'EOF'
#!/bin/bash
java -Xmx2G -Xms512M -jar server.jar nogui
EOF
        chmod +x start.sh

        cat > server.properties << 'EOF'
server-port=25565
max-players=20
difficulty=normal
gamemode=survival
online-mode=false
motd=ARCHON Minecraft Server
EOF
        screen -dmS minecraft bash start.sh
        print_success "Minecraft server started on port 25565!"
        echo -e "${CYAN}Use Cloudflare TCP tunnel or ngrok to expose port 25565${NC}"
        ;;

    2)
        print_step "Setting up Minecraft Bedrock Server..."
        mkdir -p ~/archon-bedrock
        cd ~/archon-bedrock
        wget -q https://minecraft.azureedge.net/bin-linux/bedrock-server-1.20.0.01.zip -O bedrock.zip
        unzip -q bedrock.zip
        chmod +x bedrock_server
        screen -dmS bedrock ./bedrock_server
        print_success "Bedrock server started on port 19132!"
        ;;

    3)
        print_step "Setting up Terraria Server..."
        sudo apt install -y mono-complete wget unzip
        mkdir -p ~/archon-terraria
        cd ~/archon-terraria
        wget -q https://terraria.org/api/download/server-files -O terraria-server.zip
        unzip -q terraria-server.zip
        print_success "Terraria server files downloaded!"
        echo -e "${CYAN}Run: mono TerrariaServer.exe to start${NC}"
        ;;

    4)
        print_step "Setting up CS Source Dedicated Server..."
        sudo apt install -y lib32gcc-s1 steamcmd
        mkdir -p ~/archon-csgo
        steamcmd +login anonymous +force_install_dir ~/archon-csgo +app_update 740 validate +quit
        print_success "CS server installed!"
        ;;
esac

echo ""
print_success "Game server setup complete!"
