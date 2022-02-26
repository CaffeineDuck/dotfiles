#!/bin/bash

tac /tmp/clipboard.txt | rofi -dmenu -i -p "Clipboard" -l 10 | tr -d '\n' |  xclip -sel c

