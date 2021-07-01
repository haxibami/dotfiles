#!/bin/bash
output = xprop -id $(xdotool getactivewindow) | grep '_NET_WM_NAME(UTF8_STRING)' | cut -d '"' -f2