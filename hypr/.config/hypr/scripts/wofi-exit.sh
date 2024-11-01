#!/usr/bin/env bash

# A rofi-like System/Exit menu for wofi

# wofi crashes w/ no cache file, so let's use a custom one and delete it every time, to avoid reordering entries
rm -f /home/james/.local/share/wofi/exit.cache

A=$(wofi --show dmenu --width=100 --height=190 --cache-file=/home/james/.local/share/wofi/exit.cache --prompt=System cat <<EOF
🔒 Lock
⇠ Logout
⭮ Reboot
⏻ Shutdown
⏾ Suspend
EOF
)

case "$A" in

    *Lock) swaylock -C ~/.config/swaylock/config ;;

    *Logout) swaynagmode -R -t red -m ' You are about to exit Hyprland. Proceed?' \
      -b '  Logout ' 'swaymsg exit' \
      -b '  Reload ' 'swaymsg reload' ;;

    *Reboot) swaynagmode -R -t red -m ' You are about to restart the machine? Proceed?' \
      -b '  Reboot ' 'systemctl reboot' ;;

    *Shutdown) swaynagmode -R -t red -m ' You are about to turn the machine off. Proceed?' \
      -b '  Shutdown ' 'systemctl -i poweroff' ;;

    *Suspend) 

esac

exit 0
