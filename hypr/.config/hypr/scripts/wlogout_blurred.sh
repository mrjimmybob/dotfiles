#!/bin/bash
grim /tmp/shot.png 
magick /tmp/shot.png -blur 0x7 /tmp/shot_blurred.png
wlogout --protocol layer-shell

