#!/usr/bin/env bash

# -- COLORS --
BLUE='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo -e "${BLUE}[+] Starting Setup...${NC}"

# -- INSTALL ESSENTIAL PACKAGES --
pkg update -y
pkg install x11-repo -y
pkg install vim ranger python openbox alacritty feh jp2a xcompmgr firefox tint2 xwayland termux-x11-nightly -y

# -- LOCAL CURSOR SETUP --
echo -e "${BLUE}[+] Installing cursors from local assets...${NC}"
mkdir -p ~/.icons ~/.icons/default
tar -xzf ./assets/WinSur-white-cursors.tar.gz -C ~/.icons
echo -e "[Icon Theme]\nInherits=WinSur-white-cursors" > ~/.icons/default/index.theme

# -- LOCAL OPENBOX THEME --
echo -e "${BLUE}[+] Setting Openbox themes from local assets...${NC}"
mkdir -p ~/.config/openbox
# Unzipping..
unzip -o ./assets/themes.zip -d ~/.config/openbox/
cp $PREFIX/etc/xdg/openbox/rc.xml ~/.config/openbox/rc.xml

# -- ALACRITTY CONFIG --
mkdir -p ~/.config/alacritty
cat <<EOF > ~/.config/alacritty/alacritty.toml
[window]
opacity = 0.85
padding = { x = 12, y = 12 }

[font]
size = 18.0

[colors.primary]
background = "#000000"
foreground = "#ffffff"
EOF

# -- AUTOSTART --
cat <<EOF > ~/.config/openbox/autostart
xcompmgr -c &
feh --bg-fill $HOME/termux-openbox/assets/wallpapers/blue-scan.jpg &
sed -i "s|<name>.*</name>|<name>Prismatic-Night</name>|g" ~/.config/openbox/rc.xml
tint2 &
EOF

# -- MENU CONFIG --
cat <<EOF > ~/.config/openbox/menu.xml
<?xml version="1.0" encoding="UTF-8"?>
<openbox_menu xmlns="http://openbox.org/3.4/menu">
    <menu id="root-menu" label="Openbox 3">
        
        <item label="Terminal (Alacritty)">
            <action name="Execute">
                <command>env DISPLAY=:0 LIBGL_ALWAYS_SOFTWARE=1 alacritty</command>
            </action>
        </item>

        <item label="Web Browser (Firefox)">
            <action name="Execute">
                <command>env DISPLAY=:0 LIBGL_ALWAYS_SOFTWARE=1 firefox</command>
            </action>
        </item>

        <item label="File Manager">
            <action name="Execute">
                <command>env DISPLAY=:0 LIBGL_ALWAYS_SOFTWARE=1 alacritty -e ranger</command>
            </action>
        </item>

        <item label="Vim">
            <action name="Execute">
                <command>env DISPLAY=:0 LIBGL_ALWAYS_SOFTWARE=1 alacritty -e vim</command>
            </action>
        </item>

        <separator />

        <item label="Reconfigure Openbox">
            <action name="Reconfigure" />
        </item>

        <item label="Exit">
            <action name="Exit" />
        </item>

    </menu>
</openbox_menu>
EOF

# Apply changes immediately
openbox --reconfigure

# -- START-DESKTOP --
cat <<EOF > "$PREFIX/bin/start-openbox"
#!/usr/bin/env bash

# Kill zombies :D
pkill -f com.termux.x11
rm -rf /tmp/.X11-unix

# Start X11 Server
termux-x11 :0 >/dev/null 2>&1 &
sleep 2

# Export environment variables
export DISPLAY=:0
export LIBGL_ALWAYS_SOFTWARE=1

# Launch
openbox-session &
sleep 1
alacritty &     # remove this if u dont want alacritty to open on start
EOF

chmod +x $PREFIX/bin/start-openbox

echo -e "${GREEN}[+] Setup Complete!${NC}"
echo -e "${BLUE}[+] Run: start-openbox${NC}"
