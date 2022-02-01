#!/usr/bin/env bash

# run this in sway as:
# exec wl-paste -t text --watch myclipman

app_name=$( swaymsg -t get_tree | jq -r '.. | select(.type?) | select(.focused==true) | .name' )

if [[ $app_name != "Bitwarden" ]]; then
    clipman store -P --histpath="~/.local/share/clipman-primary.json"
fi
