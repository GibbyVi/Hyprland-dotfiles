#!/bin/bash
VOL=$(pamixer --get-volume)
ICON=""
notify-send -h int:value:$VOL -u low -t 1000 -r 666 "Volumen: $VOL%" "$ICON"
