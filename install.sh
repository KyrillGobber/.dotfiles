#!/bin/bash

# TODO Add pacman install command for everything needed
# TODO Add git clone and checkout

# Create all symlinks
ln -sv ~/.dotfiles/hypr/hyprland.conf .config/hypr/
ln -sv ~/.dotfiles/kitty/kitty.conf .config/kitty/
ln -sv ~/.dotfiles/nvim/init.vim .config/nvim/
ln -sv ~/.dotfiles/waybar/config .config/waybar/
ln -sv ~/.dotfiles/waybar/style.css .config/waybar/
ln -sv ~/.dotfiles/wofi/config .config/wofi/
ln -sv ~/.dotfiles/wofi/style.css .config/wofi/
ln -sv ~/.dotfiles/wofi/powermenu .config/wofi/
ln -sv ~/.dotfiles/wofi/scripts .config/wofi/

