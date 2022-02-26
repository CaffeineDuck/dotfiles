#!/bin/bash
# changeVolume

# Arbitrary but unique message tag
msgTag="myvolume"

# Change the volume using pactl
pactl set-sink-volume 0 $1 > /dev/null

# Get volume from pactl
volume=$(pactl get-sink-volume 0 | cut -d '/' -f4 | head -n 1 | sed -e 's/ //g')

# Show the volume notification
dunstify -a "changeVolume" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag \
-h int:value:"$volume" "Volume: ${volume}"

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change -d "changeVolume"
