#!/bin/sh

scripts=$(find $1 -type f -name "*.sh" -printf "%f\n" | \
    wofi --dmenu --prompt "Scripts: ")

if [ -z "$scripts" ]; then 
    exit 0 
fi

"$1$scripts"
exit 0
