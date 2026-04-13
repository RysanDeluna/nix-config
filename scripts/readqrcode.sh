#!/bin/sh

LINK=$(grim - | zbarimg -q - | sed -e 's/QR-Code://')
if [ -z "$LINK" ]; then
    notify-send -t 5000 --urgency=low "No QR-Code found!"
    exit 1
fi
notify-send -t 5000 --urgency=low "$LINK read from QR-Code!"
printf "%s" "$LINK" | wl-copy 
