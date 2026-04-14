#!/bin/sh

grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" -
LINK=$(
    grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" - \
    | zbarimg -q - \
    | sed -e 's/QR-Code://'
)
if [ -z "$LINK" ]; then
    notify-send -t 5000 --urgency=low "No QR-Code found!"
    exit 1
fi
notify-send -t 5000 --urgency=low "$LINK read from QR-Code!"
printf "%s" "$LINK" | wl-copy 
