# ⚡ ARCHON - Free VPS Setup for Firebase IDX

> Made by **Nomaan (FADE)**  
> Get a free VPS environment instantly on Firebase IDX!

---

## 🚀 One-Click Install

Open your **Firebase IDX** terminal and run:

```bash
git clone https://github.com/yourusername/ARCHON.git && cd ARCHON && chmod +x install.sh && bash install.sh
```

---

## 📦 What's Included

| Feature | Status |
|---|---|
| 🌐 Cloudflare Tunnel | ✅ |
| 🖥️ Web Server (Nginx/Apache/Node/Python) | ✅ |
| 🤖 Bot Environment (Python + Node.js) | ✅ |
| 🎮 Game Server (Minecraft, Terraria, CS) | ✅ |
| 💤 Keep Alive Script | ✅ |
| 📊 Terminal Panel Dashboard | ✅ |

---

## 🛠️ Manual Setup

```bash
# Clone the repo
git clone https://github.com/yourusername/ARCHON.git
cd ARCHON

# Make all scripts executable
chmod +x install.sh scripts/*.sh

# Run installer
bash install.sh
```

---

## 📋 Scripts

| Script | Description |
|---|---|
| `install.sh` | Main menu installer |
| `scripts/full_setup.sh` | Install everything at once |
| `scripts/cloudflare.sh` | Setup Cloudflare tunnel |
| `scripts/webserver.sh` | Setup web server |
| `scripts/bot_env.sh` | Setup bot environment |
| `scripts/gameserver.sh` | Setup game server |
| `scripts/keepalive.sh` | Keep IDX session alive |
| `scripts/panel.sh` | Terminal dashboard panel |

---

## ⚠️ Limitations

- Not 24/7 (session ends when browser closes)
- Limited to IDX resources (~4-8GB RAM, ~2-4 CPU)
- Use Keep Alive + browser extension to extend sessions

---

## 💡 Tips

- Install **"Tab Keeper"** Chrome extension to prevent IDX from sleeping
- Use `screen` to keep processes running in background
- Use `pm2` for Node.js bots (auto-restart on crash)

---

## 📞 Support

Made with ❤️ by **Nomaan (FADE)** — Project ARCHON
