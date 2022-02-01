#!/usr/bin/env bash
# open spotify with right resolution in Xwayland(swaywm)
env GDK_BACKEND=x11 /usr/bin/spotify --force-device-scale-factor=1.75
