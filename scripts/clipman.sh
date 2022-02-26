#!/bin/bash

latest_clip=$(xclip -o -sel c)

if [ -z "$latest_clip" ]; then
    exit 1
elif [ "$latest_clip" = "$(tac /tmp/clipboard.txt | head -n 1)" ]; then
    exit 1
else 
    echo $latest_clip >> /tmp/clipboard.txt
fi
