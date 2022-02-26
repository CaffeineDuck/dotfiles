#!/bin/bash


VERTICAL=~/.screenlayout/vertical.sh
DEFAULT=~/.screenlayout/default.sh

#CURRENT_LAYOUT="$(>~/.cache/current_layout)"
CURRENT_LAYOUT=`cat ~/.cache/current_layout`
echo "Current layout: $CURRENT_LAYOUT"

next_layout() {
    if [[ "$CURRENT_LAYOUT" -eq 1 ]]; then
        source $VERTICAL
        CURRENT_LAYOUT=2
    elif [[ "$CURRENT_LAYOUT" -eq 2 ]]; then
        source $DEFAULT
        CURRENT_LAYOUT=1
    else 
        source $VERTICAL
        CURRENT_LAYOUT=1
    fi
}

case $1 in 
    vertical)
        source "$VERTICAL"
        CURRENT_LAYOUT=2
        ;;
    default)
        source "$DEFAULT"
        CURRENT_LAYOUT=1
        ;;
    next)
        next_layout
        ;;
    *)
        echo "Usage: $0 {vertical|default|next}"
        exit 1
        ;;
esac

echo $CURRENT_LAYOUT > ~/.cache/current_layout

