#!/bin/bash

# Terminate already running bar instances
killall -q waybar

# Wait until the processes have been shut down
while pgrep -u $UID -x waybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
waybar &

echo "waybar launched..."
