#!/usr/bin/env bash
ws="$1"

# 1. Define wallpapers explicitly
case "$ws" in
1) IMG="$HOME/.config/hypr/walls/1.jpg" ;;
2) IMG="$HOME/.config/hypr/walls/2.jpg" ;;
3) IMG="$HOME/.config/hypr/walls/3.jpg" ;;
4) IMG="$HOME/.config/hypr/walls/4.jpg" ;;
5) IMG="$HOME/.config/hypr/walls/5.jpg" ;;
6) IMG="$HOME/.config/hypr/walls/6.jpg" ;;
7) IMG="$HOME/.config/hypr/walls/7.jpg" ;;
8) IMG="$HOME/.config/hypr/walls/8.jpg" ;;
9) IMG="$HOME/.config/hypr/walls/9.jpg" ;;
10) IMG="$HOME/.config/hypr/walls/0.jpg" ;;
esac

awww img "$IMG" --transition-type none

#swww img "$IMG" --transition-type grow --transition-pos 0.5,0.5 --transition-duration 1 --transition-fps 60
