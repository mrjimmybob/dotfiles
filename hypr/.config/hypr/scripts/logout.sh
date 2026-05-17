#!/usr/bin/env bash

# Ask Brave to exit cleanly
pkill -TERM brave

# Give it a moment to write session
sleep 2

hyprctl dispatch exit
