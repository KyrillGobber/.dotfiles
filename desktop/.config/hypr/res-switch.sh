#!/bin/bash

output="DP-1"
current_res=$(hyprctl monitors -j | jq -r '.[] | select(.name == "'$output'") | .width')

if [ "$current_res" = "2560" ]; then
  hyprctl keyword monitor $output,1920x1080@360
else
  hyprctl keyword monitor $output,2560x1440@360,0x0,1,bitdepth,10
fi
