# Desktop Icon Toggle

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Toggle desktop icons on/off with a single keyboard shortcut. Built for Linux Mint / Cinnamon.

## What It Does

Press **Super+H** and your desktop icons instantly hide. Press it again, they're back. Perfect for screen sharing, presentations, or keeping a clean workspace.

A desktop notification confirms the current state each time you toggle.

## Requirements

- Linux Mint with Cinnamon desktop (or any DE using Nemo file manager)
- `gsettings` (pre-installed on Cinnamon)
- `notify-send` (pre-installed — part of `libnotify`)

## Install

```bash
git clone https://github.com/markdborden/desktop-icon-toggle.git
cd desktop-icon-toggle
chmod +x install.sh
./install.sh
```

This copies the script to `~/.local/bin/` and registers **Super+H** as a custom keybinding in Cinnamon.

## Manual Install

1. Copy the script somewhere on your `$PATH`:

```bash
cp toggle-desktop-icons.sh ~/.local/bin/
chmod +x ~/.local/bin/toggle-desktop-icons.sh
```

2. Open **System Settings → Keyboard → Shortcuts → Custom Shortcuts**
3. Add a new shortcut:
   - **Name:** Toggle Desktop Icons
   - **Command:** `~/.local/bin/toggle-desktop-icons.sh`
   - **Keybinding:** Press your preferred key combo

## Customize the Keybinding

To use a different shortcut, edit the keybinding after install:

1. Open **System Settings → Keyboard → Shortcuts → Custom Shortcuts**
2. Find "Toggle Desktop Icons"
3. Click the keybinding and press your new combo

Or edit via CLI:

```bash
dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/toggle-desktop-icons/binding "['<Control><Alt>h']"
```

## How It Works

The script is 12 lines of bash:

```bash
#!/bin/bash
CURRENT=$(gsettings get org.nemo.desktop show-desktop-icons)

if [ "$CURRENT" = "true" ]; then
    gsettings set org.nemo.desktop show-desktop-icons false
    notify-send "Desktop Icons" "Hidden" -t 1500
else
    gsettings set org.nemo.desktop show-desktop-icons true
    notify-send "Desktop Icons" "Visible" -t 1500
fi
```

It reads the current `show-desktop-icons` setting via `gsettings`, flips it, and sends a brief notification.

## Adapting for Other Desktops

**GNOME (Ubuntu):**
```bash
gsettings set org.gnome.desktop.background show-desktop-icons false
```

**KDE Plasma:**
Desktop icons are handled by the "Desktop Folder" widget — toggle it via right-click → Configure Desktop.

## Uninstall

```bash
./uninstall.sh
```

Removes the script and keybinding.

## License

MIT
