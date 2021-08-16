#!/bin/bash

export XDG_SESSION_TYPE=wayland;
export XDG_CURRENT_DESKTOP=sway;
export XDG_CURRENT_SESSION=sway;
export SDL_VIDEODRIVER=wayland;
export LIBSEAT_BACKEND=logind;
export QT_QPA_PLATFORM=wayland;


sleep 1;
exec sway
