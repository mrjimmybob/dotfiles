#!/usr/bin/env fish

# Polling interval in seconds
set interval 0.2

# Store the last active workspace to detect changes
set -l last_ws ""

while true
    # Get the active workspace number via hyprctl JSON
    set active_ws (hyprctl workspaces -j | jq -r '.[] | select(.focused==true) | .id')

    # If the workspace changed
    if test "$active_ws" != "$last_ws"
        # Update last_ws
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

    sleep $interval
end
