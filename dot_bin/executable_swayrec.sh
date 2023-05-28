#!/usr/bin/env bash

pid=`pgrep wf-recorder`
status=$?

if [ $status != 0 ] 
then 
  notify-send --app-name="Recorder" --urgency=low --icon=media-record "wf-recorder" "Recording start"
  wf-recorder -f $(xdg-user-dir VIDEOS)/screencapture/$(date +'%Y-%m-%d_%H-%M-%S.mp4') -c h264_vaapi -d /dev/dri/renderD128 -g "$(slurp -f '%x,%y %wx%h' -d -b 00000066)"
else 
  pkill --signal SIGINT wf-recorder
  notify-send --app-name="Recorder" --urgency=low --icon=media-record "wf-recorder" "Recording stopped"
fi;
