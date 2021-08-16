#!/bin/bash

# Clone of `playerctl`. Sends the second argument (e.g. `PlayPause` `Pause` etc.) to the first argument's media player.
function pctl {
    dbus-send --type=method_call --dest="org.mpris.MediaPlayer2.$1" /org/mpris/MediaPlayer2 "org.mpris.MediaPlayer2.Player.$2"
}

# Super-fast compared to $(playerctl status)
# Gets the property of the media player defined by the first argument filtered by the second argument.
# To get the playback status of `spotifyd`, use `pctl_get "spotifyd" "PlaybackStatus"`
function pctl_get {
    # Get the data from DBUS
    response="$(dbus-send --reply-timeout=1000 --print-reply --dest="org.mpris.MediaPlayer2.$1" /org/mpris/MediaPlayer2 "org.freedesktop.DBus.Properties.Get" string:"org.mpris.MediaPlayer2.Player" string:"$2")"
    # If the response was a error
    if [[ $? != 0 ]]; then
        echo "Stopped"
    else
        # Else get the actual response
        echo "$(echo "$response" | tr ";" "\n")[2]"
    fi
}

# Cache the initial status of spotifyd
spt_status="$(pctl_get "spotifyd" "PlaybackStatus")"

# Gets a media player (returned by `playerctl -l`). This prefers spotifyd above all other.
function pref_spt {
    player=$(playerctl -l | grep "spotifyd")

    if [[ "$?" == 0 ]]; then
        player=$(echo $player | head -n 1)
    else
        player=$(playerctl -l | head -n 1)
    fi

    echo "$player"
}

# Loop on each media player
# This checks for any media player playing, and if they are, pause and exit.
for player in $(playerctl -l); do
    echo $player
    # If it's spotifyd
    if [[ "$player" == *"spotifyd"* ]]; then
        # and playing, pause it.
        if [[ "$spt_status" == *"Playing"* ]]; then
            pctl $player "Pause"
            exit 0
        fi
    else
        # Else, if the status of the player is `Playing`, pause it and exit
        if [[ "$(pctl_get $player "PlaybackStatus")" == *"Playing"* ]]; then
            pctl $player "Pause"
            exit 0
        fi
    fi
done

# If there was nothing to pause (the we would've `exit`ed), play from the preferred editor.
pctl $(pref_spt) "Play"
