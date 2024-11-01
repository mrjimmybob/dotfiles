#!/bin/bash

entries="⇠ Logout\n⏾ Suspend\n⭮ Reboot\n⏻  Shutdown"
# Power symbols: ⏻ ⏼ ⏽ ⭘ ⏾
selected=$(echo -e $entries|wofi --width 100 --height 170 --dmenu --cache-file /dev/null|awk '{print tolower($2)}')

case $selected in
  logout)
    exec /home/james/.config/hypr/scripts/logout.sh ;;
  suspend)
    exec /home/james/.config/hypr/scripts/suspend.sh ;;
  reboot)
    exec /home/james/.config/hypr/scripts/reboot.sh ;;
  shutdown)
    exec /home/james/.config/hypr/scripts/shutdown.sh ;;
esac

