#!/bin/bash

# ============================================
#        ARCHON - Keep Alive Script
# ============================================

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m'

print_success() { echo -e "${GREEN}[✓]${NC} $1"; }

echo -e "${CYAN}Setting up Keep Alive...${NC}"
echo ""

# Create keep alive script
cat > ~/archon_keepalive.sh << 'EOF'
#!/bin/bash
# ARCHON Keep Alive Script
while true; do
    echo "[ARCHON] Session alive at: $(date)"
    # Simulate activity to prevent sleep
    ls /tmp > /dev/null 2>&1
    sleep 30
done
EOF

chmod +x ~/archon_keepalive.sh

# Run in background screen
screen -dmS archon_keepalive bash ~/archon_keepalive.sh

print_success "Keep alive script running in screen 'archon_keepalive'"
echo ""
echo -e "${WHITE}Useful screen commands:${NC}"
echo -e "  ${CYAN}View all screens:${NC}  screen -ls"
echo -e "  ${CYAN}Attach to screen:${NC}  screen -r archon_keepalive"
echo -e "  ${CYAN}Detach screen:${NC}     Ctrl+A then D"
echo -e "  ${CYAN}Kill screen:${NC}       screen -X -S archon_keepalive quit"
echo ""
echo -e "${YELLOW}Tip: Also install 'Tab Keeper' Chrome extension to prevent IDX tab from sleeping!${NC}"
