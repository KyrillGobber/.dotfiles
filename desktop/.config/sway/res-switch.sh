#!/bin/bash

output="DP-1"
current_res=$(swaymsg -t get_outputs | jq -r '.[] | select(.name == "'$output'") | .current_mode.width')

if [ "$current_res" = "2560" ]; then
  swaymsg output $output mode 1920x1080
else
  swaymsg output $output mode 2560x1440
fi
