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
#   - xdg portal stuff
# - nextcloud
# - polkit-gnome / xfce-polkit
# - grim + slurp + swappy
# - wl-clipboard
# - ripgrep
# - kmonad
#   - create Udev rules
#   - create systemd service
# - tlp for laptops
# - light (for display brightness)
# - Lid close action and stuff: /etc/systemd/logind.conf or acpid
# - tmux
#   - tmux package manager git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
#   - tmuxifier https://github.com/jimeh/tmuxifier


# vim-plug:
# sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
#       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# TODO Add git clone and checkout

# Create all symlinks
ln -sv ~/.dotfiles/hypr/ .config/
ln -sv ~/.dotfiles/kitty/ .config/
ln -sv ~/.dotfiles/nvim/ .config/
ln -sv ~/.dotfiles/waybar/ .config/
ln -sv ~/.dotfiles/wofi/ .config/
ln -sv ~/.dotfiles/tmux/ .config/

