#!/bin/bash
# Install desktop-icon-toggle for Linux Mint / Cinnamon

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_DIR="$HOME/.local/bin"

# Create install directory if needed
mkdir -p "$INSTALL_DIR"

# Copy script
cp "$SCRIPT_DIR/toggle-desktop-icons.sh" "$INSTALL_DIR/toggle-desktop-icons.sh"
chmod +x "$INSTALL_DIR/toggle-desktop-icons.sh"

# Set up Cinnamon custom keybinding (Super+H)
# Read existing custom keybindings
EXISTING=$(dconf read /org/cinnamon/desktop/keybindings/custom-list 2>/dev/null || echo "[]")

# Create a new keybinding entry
BINDING_NAME="toggle-desktop-icons"
BINDING_PATH="/org/cinnamon/desktop/keybindings/custom-keybindings/$BINDING_NAME/"

dconf write "$BINDING_PATH"name "'Toggle Desktop Icons'"
dconf write "$BINDING_PATH"command "'$INSTALL_DIR/toggle-desktop-icons.sh'"
dconf write "$BINDING_PATH"binding "['<Super>h']"

# Add to custom keybinding list if not already present
if echo "$EXISTING" | grep -q "$BINDING_NAME"; then
    echo "Keybinding already registered."
else
    if [ "$EXISTING" = "[]" ] || [ "$EXISTING" = "@as []" ] || [ -z "$EXISTING" ]; then
        NEW_LIST="['$BINDING_NAME']"
    else
        # Remove trailing bracket, append new entry
        NEW_LIST="${EXISTING%]*}, '$BINDING_NAME']"
    fi
    dconf write /org/cinnamon/desktop/keybindings/custom-list "$NEW_LIST"
fi

echo ""
echo "✓ Installed toggle-desktop-icons.sh to $INSTALL_DIR"
echo "✓ Keybinding set: Super+H"
echo ""
echo "Press Super+H to toggle desktop icons on/off."
