#!/bin/bash

# TODO Add pacman install command for everything needed
# - git
# - kitty
# - hyprland
#   - waybar
#     - waybar-mpris-git
#     - blueman-applet
#   - swaylock
#   - swaybg -> switch to hyprpaper?
#   - wofi
#   - pavocontrol
# - nextcloud
# - polkit-gnome / xfce-polkit
# - grim + slurp + swappy
# 
# vim-plug:
# sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
#       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

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

