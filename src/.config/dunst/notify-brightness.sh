#!/bin/bash
BRI=$(brightnessctl get)
MAX=$(brightnessctl max)
PERC=$((BRI * 100 / MAX))
ICON=""
notify-send -h int:value:$PERC -u low -t 1000 -r 667 "Brillo: $PERC%" "$ICON"
