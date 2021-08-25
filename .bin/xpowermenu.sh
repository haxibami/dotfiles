#!/usr/bin/env bash

menu=$( echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout" | rofi -p "power" -dmenu -width 500 --lines=5 -theme ~/.config/rofi/powermenu.rasi | awk '{print tolower($2)}' )

case $menu in 
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
                systemctl $menu
                ;;
        lock)
            		~/.bin/myi3lock.sh
                ;;
        logout)
                i3-msg exit
                ;;
esac
