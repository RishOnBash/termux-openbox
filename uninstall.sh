#!/usr/bin/env bash

# -- COLORS --
RED='\033[1;31m'
NC='\033[0m'

echo -e "${RED}[!] Uninstalling termux-openbox environment...${NC}"

# -- STOP ACTIVE SESSIONS --
echo "[+] Stopping X11 and background processes..."
pkill -f com.termux.x11
pkill -9 openbox
pkill -9 alacritty
pkill -9 tint2
pkill -9 xcompmgr
rm -rf /tmp/.X11-unix

# -- REMOVE START SCRIPT --
echo "[+] Removing custom start-openbox script..."
rm -f $PREFIX/bin/start-desktop

# -- REMOVE PACKAGES --
echo "[+] Removing packages..."
# Note: i didn't add firefox and termux-x11-nightly cause i need them (:
pkg uninstall geany openbox alacritty feh jp2a xcompmgr pcmanfm tint2 xwayland -y
pkg autoremove -y

# -- DELETE CONFIGURATIONS --
echo "[+] Deleting config directories..."
rm -rf ~/.config/openbox
rm -rf ~/.config/alacritty
rm -rf ~/.config/tint2
rm -rf ~/.icons/default
rm -rf ~/.icons/WinSur-white-cursors

echo -e "${RED}[+] Noir-X11 has been purged.${NC}"