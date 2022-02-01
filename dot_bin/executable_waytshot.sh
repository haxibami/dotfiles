#!/usr/bin/env bash

#menu=$( wofi -i -b -p waitfor --dmenu --width 300 --lines=1 --style=${HOME}/.config/wofi/powermenu.css --conf=${HOME}/.config/wofi/powermenu.conf )

#if [[ $menu -gt 0 && $menu -lt 30 ]]; then
#  sleep $menu; grimshot --notify save active ~/Pictures/screenshot/$(date "+%Y%m%d-%H%M%S")'_grim_active.png'
#else 
#  :
#fi

sleep 8; grimshot --notify save active ~/Pictures/screenshot/$(date "+%Y%m%d-%H%M%S")'_grim_active.png'
