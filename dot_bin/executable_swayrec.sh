#!/usr/bin/env bash

pid=$(pgrep wl-screenrec)
status=$?
mode=$1

if [ $status != 0 ] 
then 
  if [ -z "$mode" ] 
  then 
    mode="area"
  fi;
  if [ "$mode" == "area" ] 
  then 
    notify-send --app-name="Recorder" --urgency=low --icon=media-record "wl-screenrec" "Recording start"
    wl-screenrec -f $(xdg-user-dir VIDEOS)/screencapture/$(date +'%Y-%m-%d_%H-%M-%S.mp4') -g "$(slurp)"
  elif [ "$mode" == "window" ]
  then 
    notify-send --app-name="Recorder" --urgency=low --icon=media-record "wl-screenrec" "Recording start"
    wl-screenrec -f $(xdg-user-dir VIDEOS)/screencapture/$(date +'%Y-%m-%d_%H-%M-%S.mp4') -g "$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | select(.type=="con") | select(.focused==true) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')"
  elif [ "$mode" == "output" ]
  then
    notify-send --app-name="Recorder" --urgency=low --icon=media-record "wl-screenrec" "Recording start"
    wl-screenrec -f $(xdg-user-dir VIDEOS)/screencapture/$(date +'%Y-%m-%d_%H-%M-%S.mp4')
  fi;
else 
  pkill --signal SIGINT wl-screenrec
  notify-send --app-name="Recorder" --urgency=low --icon=media-record "wl-screenrec" "Recording stopped"
fi;
