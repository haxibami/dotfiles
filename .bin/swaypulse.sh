#!/usr/bin/env bash

# a script to choose pulseaudio default sink and source, via wofi, pamixer, pactl.
# requires: bash, wofi, pamixer, pactl (you can also use dmenu alternatives: eg. rofi, dmenu)

#sinklist=$(pamixer --list-sinks | grep output | awk -F\" '{print $2}' | tr ' ' '\n')
#sinknamelist=$(pamixer --list-sinks | grep output | awk -F\" '{print $4}')

setdefault () {
  menu=$(pamixer --list-sources | grep $2 | awk -F\" '{print $2}' | wofi -i -b -p $1-list --dmenu --width 1000 --lines=5 --style=${HOME}/.config/wofi/powermenu.css --conf=${HOME}/.config/wofi/powermenu.conf) &&
    pactl set-default-$1 ${menu}
}

pref=$(echo -e " input\n墳 output" | wofi -i -b -p in/out --dmenu --width 300 --lines=2 --style=${HOME}/.config/wofi/powermenu.css --conf={$HOME}/.config/wofi/powermenu.conf | awk '{print tolower($2)}' )&&
  case $pref in
    input)
      setdefault "source" "input"
      ;; 
    output)
      setdefault "sink" "output"
      ;;

  esac


#menu=$(pamixer --list-${target} | grep ${io} | awk -F\" '{print $2}' | wofi -i -b -p sink-list --dmenu --width 1000 --lines=5 --style=${HOME}/.config/wofi/powermenu.css --conf=${HOME}/.config/wofi/powermenu.conf) &&

#for sink in $menu
#sink=$(ponymix -t sink list|awk '/^sink/ {s=$1" "$2;getline;gsub(/^ +/,"",$0);print s" "$0}'| wofi --dmenu -p 'pulseaudio sink:' --width 500 | grep -Po '[0-9]+(?=:)') &&

#ponymix set-default -d $sink &&
#for input in $(ponymix list -t sink-input|grep -Po '[0-9]+(?=:)');do
#	echo "$input -> $sink"
#	ponymix -t sink-input -d $input move $sink
#done
