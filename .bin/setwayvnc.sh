#!/bin/sh
swaymsg -t get_outputs | grep HEADLESS-1 || {
  swaymsg create_output HEADLESS-1
}

wayvnc --output=HEADLESS-1 --max-fps=30 0.0.0.0 &
