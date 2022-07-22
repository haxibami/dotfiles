#!/usr/bin/env bash
# a script to switch between sway windows (like `alt+tab` in Windows).
# requires: wofi, jq

killall -q wofi || { swaymsg -t get_tree |
 jq -r '.nodes[].nodes[] | if .nodes then [recurse(.nodes[])] else [] end + .floating_nodes | .[] | select(.nodes==[]) | ((.id | tostring) + " " + .name)' |
 wofi -d -p window | {
   read -r id name
   swaymsg "[con_id=$id]" focus
}
}
