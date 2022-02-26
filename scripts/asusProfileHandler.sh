#!/bin/bash

asusctl profile --next
dunstify -a "Asuswrt"  "$(asusctl profile --profile-get)"
