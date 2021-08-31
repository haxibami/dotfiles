#!/usr/bin/env bash

# choose pulseaudio sink and sources via wofi

#sinklist=$(pamixer --list-sinks | grep output | awk -F\" '{print $2}' | tr ' ' '\n')
#sinknamelist=$(pamixer --list-sinks | grep output | awk -F\" '{print $4}')

pref=$(echo -e "input\noutput" | wofi -i -b -p in/out --dmenu --width 300 --lines=2 --style=${HOME}/.config/wofi/powermenu.css --conf={$HOME}/.config/wofi/powermenu.conf)&&

case $pref in
  input)
    target=sources && io=$pref
    menu=$(pamixer --list-sources | grep input | awk -F\" '{print $2}' | wofi -i -b -p source-list --dmenu --width 1000 --lines=5 --style=${HOME}/.config/wofi/powermenu.css --conf=${HOME}/.config/wofi/powermenu.conf) &&
    pactl set-default-source $menu
    ;; 
  output)
    target=sinks && io=$pref
    menu=$(pamixer --list-sinks | grep output | awk -F\" '{print $2}' | wofi -i -b -p sink-list --dmenu --width 1000 --lines=5 --style=${HOME}/.config/wofi/powermenu.css --conf=${HOME}/.config/wofi/powermenu.conf) &&
    pactl set-default-sink $menu
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
