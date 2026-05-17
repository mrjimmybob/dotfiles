#!/bin/bash
# $1 is the workspace number
WS=$1
MONITOR="DP-3"
WALLPAPER_DIR="$HOME/.config/hypr/walls"

# Check if file exists for workspace, default to 0.jpg
FILE="$WALLPAPER_DIR/$WS.jpg"
if [ ! -f "$FILE" ]; then
    FILE="$WALLPAPER_DIR/0.jpg"
fi

hyprctl workspace "$WS"
hyprctl hyprpaper wallpaper "$MONITOR,$FILE"
