#!/bin/sh
swaymsg -t get_outputs | grep HEADLESS-1 &> /dev/null || {
  swaymsg create_output HEADLESS-1
}

wayvnc --output=HEADLESS-1 0.0.0.0 &
