#!/bin/sh
read lcd < /tmp/lcd
    if [ "$lcd" -eq "0" ]; then
        wlopm --off '*'
        echo 1 > /tmp/lcd
    else
        wlopm --on '*'
        echo 0 > /tmp/lcd
    fi
