#!/usr/bin/env bash

# if this script is not active, ask which region (fullscreen or area) to record, and start recording.
# else, send termination to the process, meaning stopping recording.


PIDS=$(ps -ef | grep .bin/swayrec.sh | grep bash | grep -v grep | awk '{ print $2 }')
THIS=$(echo ${PIDS} | awk '{print $1}')

if [ $(echo ${PIDS} | wc -w) != 2 ]; then
#  kill -INT ${PID} &&
    ~/.bin/killtree.sh "${THIS}" INT
    TITLE="swayrec stopped"
    MESSAGE="Successfully stopped swayrec"
    notify-send -t 3000 "${TITLE}" "${MESSAGE}" 

else
  pref=$(echo -e " full\n area" | wofi -i -b -p capture --dmenu --width 300 --lines=2 --style=${HOME}/.config/wofi/powermenu.css --conf={$HOME}/.config/wofi/powermenu.conf | awk '{print tolower($2)}')&&
    case $pref in
      full)
        TITLE="swayrec started"
        MESSAGE="started swayrec: full mode"
        notify-send -t 3000 "${TITLE}" "${MESSAGE}"
        wf-recorder -f ~/Videos/Screencapture/$(date "+%Y%m%d-%H%M%S")'_wfrec_full.mp4' || {
            TITLE="exit"
            MESSAGE="canceled by <Esc>"
            notify-send -t 3000 "${TITLE}" "${MESSAGE}"
          }
        ;;
      area)
        TITLE="swayrec started"
        MESSAGE="started swayrec: area mode"
        notify-send -t 3000 "${TITLE}" "${MESSAGE}"
        AREA=$(slurp)&&
          wf-recorder -g "${AREA}" -f ~/Videos/Screencapture/$(date "+%Y%m%d-%H%M%S")'_wfrec_area.mp4' || {
            TITLE="exit"
            MESSAGE="canceled by <Esc>"
            notify-send -t 3000 "${TITLE}" "${MESSAGE}"
          }
        ;;
    esac

fi
