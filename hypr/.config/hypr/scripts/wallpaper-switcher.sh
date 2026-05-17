#!/usr/bin/env bash
# ~/.config/hypr/scripts/wallpaper-switcher.sh

# Monitor to apply wallpapers on
MONITOR="DP-3"

# Directory containing your wallpapers named 1.jpg, 2.jpg, ..., 10.jpg
WALLS_DIR="$HOME/.config/hypr/walls"

# Listen to Hyprland events
hyprctl --listen events | while read -r line; do
    # Look for workspace change events
    if [[ "$line" =~ "workspace" ]]; then
        # Extract workspace number (1-10)
        WS=$(echo "$line" | grep -oP 'workspace (\d+)' | awk '{print $2}')
        FILE="$WALLS_DIR/$WS.jpg"

        # Only change wallpaper if file exists
        if [[ -f "$FILE" ]]; then
            hyprctl hyprpaper wallpaper "$MONITOR,$FILE"
        fi
    fi
done
