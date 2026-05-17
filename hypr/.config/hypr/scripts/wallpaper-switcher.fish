#!/usr/bin/env fish

# Ensure inotify-tools is installed
# sudo apt install inotify-tools

# Path to the Hyprland socket or log directory
set HYPR_LOG_DIR ~/.config/hypr/scripts

# Store last workspace to detect changes
set -l last_ws ""

# Infinite loop watching workspace changes via JSON output
while true
    # Wait for filesystem event (modify or create)
    inotifywait -q -e modify,create $HYPR_LOG_DIR &>/dev/null

    # Get active workspace
    set active_ws (hyprctl workspaces -j | jq -r '.[] | select(.focused==true) | .id')

    # If workspace changed
    if test "$active_ws" != "$last_ws"
        set last_ws $active_ws

        # Map workspace to wallpaper
        switch $active_ws
            case 1
                set wallpaper "/home/dallas/.config/hypr/walls/1.jpg"
            case 2
                set wallpaper "/home/dallas/.config/hypr/walls/2.jpg"
            case 3
                set wallpaper "/home/dallas/.config/hypr/walls/3.jpg"
            case 4
                set wallpaper "/home/dallas/.config/hypr/walls/4.jpg"
            case 5
                set wallpaper "/home/dallas/.config/hypr/walls/5.jpg"
            case 6
                set wallpaper "/home/dallas/.config/hypr/walls/6.jpg"
            case 7
                set wallpaper "/home/dallas/.config/hypr/walls/7.jpg"
            case 8
                set wallpaper "/home/dallas/.config/hypr/walls/8.jpg"
            case 9
                set wallpaper "/home/dallas/.config/hypr/walls/9.jpg"
            case 10
                set wallpaper "/home/dallas/.config/hypr/walls/0.jpg"
            case '*'
                set wallpaper "/home/dallas/.config/hypr/walls/0.jpg"
        end

        # Apply wallpaper
        hyprctl hyprpaper wallpaper "DP-3,$wallpaper"
    end
end
