#!/usr/bin/env bash

op=$(printf '%s\n' Poweroff Reboot Lock Logout Suspend | tofi --config "$HOME/.config/tofi/powermenu")

case "$op" in
  Poweroff|Reboot|Suspend)
    systemctl "${op,,}"
    ;;
  Lock)
    swaylock
    ;;
  Logout)
    pkill -KILL -u "$USER"
    ;;
esac
