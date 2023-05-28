#!/bin/sh
read lcd < /tmp/lcd
    if [ "$lcd" -eq "0" ]; then
        swaymsg "output * power on"
        echo 1 > /tmp/lcd
    else
        swaymsg "output * power off"
        echo 0 > /tmp/lcd
    fi
