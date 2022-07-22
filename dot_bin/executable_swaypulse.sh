#!/usr/bin/env bash

# script to choose pipewire default sink / source on wlroots-based compositor.
# requirement: wofi, pw-dump, wpctl, notify-send

OUTPUT_IMAGE=/usr/share/icons/WhiteSur/devices/scalable/audio-speakers.svg
INPUT_IMAGE=/usr/share/icons/WhiteSur/devices/scalable/audio-input-microphone.svg

setdefault () {
  entry=$(pw-dump |
    jq --arg which $1 '.[] | select (.info.props."media.class" == ("Audio/" +$which))' |
    jq -s '.[] | .id, .info.props."node.description"' |
    sed -z 's/\n"/ "/g' |
    tr -d \" |
    wofi -i -b -p $1-list -d -W 1200 -L 5) &&
    id=$(echo -e ${entry} | awk '{print $1}') &&
      wpctl set-default "${id}" && 
        case $1 in
          Source)
            notify-send --urgency=low --icon=${INPUT_IMAGE} "PipeWire" "Default $1:\n${entry}"
            ;;
          Sink)
            notify-send --urgency=low --icon=${OUTPUT_IMAGE} "PipeWire" "Default $1:\n${entry}"
            ;;
        esac
}

mode=$(echo -e "img:${INPUT_IMAGE}:text:input\nimg:${OUTPUT_IMAGE}:text:output" |
  wofi -i -b -p Audio -d -O alphabetical -W 300 -L 2) &&
  case $mode in
    *input)
      setdefault "Source"
      ;; 
    *output)
      setdefault "Sink"
      ;;
  esac
