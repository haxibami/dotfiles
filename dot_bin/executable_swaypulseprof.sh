#!/usr/bin/env bash

menu=$( echo -e "Analog\nHDMI" | wofi -i -b -p profile --dmenu --width 300 --lines=2 --style=${HOME}/.config/wofi/powermenu.css --conf={$HOME}/.config/wofi/powermenu.conf )&&

  case $menu in
    "Analog")
      pactl set-card-profile alsa_card.pci-0000_00_1f.3 output:analog-stereo+input:analog-stereo
      ;;
    "HDMI")
      pactl set-card-profile alsa_card.pci-0000_00_1f.3 output:hdmi-stereo
      ;;
  esac
