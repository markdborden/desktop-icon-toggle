#!/bin/bash
# Uninstall desktop-icon-toggle

set -e

INSTALL_DIR="$HOME/.local/bin"
BINDING_NAME="toggle-desktop-icons"
BINDING_PATH="/org/cinnamon/desktop/keybindings/custom-keybindings/$BINDING_NAME/"

# Remove script
if [ -f "$INSTALL_DIR/toggle-desktop-icons.sh" ]; then
    rm "$INSTALL_DIR/toggle-desktop-icons.sh"
    echo "✓ Removed $INSTALL_DIR/toggle-desktop-icons.sh"
else
    echo "Script not found at $INSTALL_DIR/toggle-desktop-icons.sh"
fi

# Remove keybinding
dconf reset -f "$BINDING_PATH" 2>/dev/null || true

# Remove from custom keybinding list
EXISTING=$(dconf read /org/cinnamon/desktop/keybindings/custom-list 2>/dev/null || echo "[]")
if echo "$EXISTING" | grep -q "$BINDING_NAME"; then
    NEW_LIST=$(echo "$EXISTING" | sed "s/, '$BINDING_NAME'//g" | sed "s/'$BINDING_NAME', //g" | sed "s/'$BINDING_NAME'//g")
    # Clean up empty list
    if [ "$NEW_LIST" = "[]" ] || [ "$NEW_LIST" = "['']" ]; then
        NEW_LIST="@as []"
    fi
    dconf write /org/cinnamon/desktop/keybindings/custom-list "$NEW_LIST"
    echo "✓ Removed keybinding"
else
    echo "Keybinding not found in custom list"
fi

echo ""
echo "Desktop icon toggle has been uninstalled."
