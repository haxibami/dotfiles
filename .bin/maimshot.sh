#!/usr/bin/env bash
maim -g $(i3-msg -t get_tree | jq -r '.. | select(.id? and .focused?) | .rect | "\(.width)x\(.height)+\(.x)+\(.y)"' | slop -f "%wx%h+%x+%y") ~/Pictures/Screenshots/$(date "+%Y%m%d-%H%M%S")'_maim_window.png'
