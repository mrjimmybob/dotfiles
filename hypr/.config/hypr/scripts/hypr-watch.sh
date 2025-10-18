#!/usr/bin/env bash
CONFIG="$HOME/.config/hypr"
watchexec -e conf --restart --clear "hyprctl reload" "$CONFIG"
