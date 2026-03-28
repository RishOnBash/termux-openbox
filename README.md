# 🌌 termux-openbox
A high-performance, minimalist desktop environment for Termux using Openbox and Termux-X11.

> Chances of it working is variable may work on your device or maybe not at all :/

## ⚡ Features
- Window Manager: Openbox
- Terminal: Alacritty
- Taskbar: Tint2
- Engine: Termux-X11 + XWayland
- Customization: WinSur White Cursors & Prismatic-Night theme included.

## 🛠️ Installation

1. **Prerequisites**

Ensure you have the Termux-X11 app installed on your Android device.

2. **Clone and Setup**

```bash
git clone https://github.com/RishOnBash/termux-openbox.git
cd termux-openbox
chmod +x install.sh && ./install.sh
```
3. **Usage**
In Termux, run the start command: `start-openbox`
Now, open Termux-X11

## 🗑 Uninstallation

```bash
cd termux-openbox
chmod +x uninstall.sh && ./uninstall.sh
```

## ⌨️  Default Keybindings

Right Click: Open Root Menu (Apps/Exit).

Alt + F4: Close Window.

## 🛡️ Stability Note
This environment uses `LIBGL_ALWAYS_SOFTWARE=1`. This prevents common `EGL_BAD_ACCESS` and `GLSL` version errors found on modern Android drivers.

## ⚖️ License
Distributed under the MIT License. See LICENSE for more information.