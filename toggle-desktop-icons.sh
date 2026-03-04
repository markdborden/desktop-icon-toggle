#!/bin/bash
# Toggle desktop icons on/off for Linux Mint

CURRENT=$(gsettings get org.nemo.desktop show-desktop-icons)

if [ "$CURRENT" = "true" ]; then
    gsettings set org.nemo.desktop show-desktop-icons false
    notify-send "Desktop Icons" "Hidden" -t 1500
else
    gsettings set org.nemo.desktop show-desktop-icons true
    notify-send "Desktop Icons" "Visible" -t 1500
fi
