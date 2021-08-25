#!/usr/bin/env bash

menu=$( echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout" | wofi -i -b -p powermenu --dmenu --width 300 --lines=5 --style=${HOME}/.config/wofi/powermenu.css --conf={$HOME}/.config/wofi/powermenu.conf | awk '{print tolower($2)}' )

case $menu in 
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
                systemctl $menu
                ;;
        lock)
            		env LANG=en.US_UTF-8 swaylock -f
                ;;
        logout)
                swaymsg exit
                ;;
esac
