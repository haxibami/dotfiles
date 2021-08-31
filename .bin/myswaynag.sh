#!/usr/bin/env bash
#swaynagmode -i 3 -R -M swnag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit' -b 'Suspend' 'systemctl suspend' -b 'Reboot' 'reboot' -b 'Shutdown' 'shutdown now'
swaynagmode -t warning -m 'hey!' -b 'a' 'notify-send -u critical "oops!"' -b 'b' 'notify-send -u low "hello"' -R
