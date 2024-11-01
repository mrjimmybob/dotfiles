#/run/current-system/sw/bin/bash

swayidle -w timeout 600 'swaylock -c ~/.config/swaylock/config' timeout 1200 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
