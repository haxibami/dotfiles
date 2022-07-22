#!/usr/bin/env bash

# a script to switch GTK theme according to time
# requires: gsettings, sunwait

MODE=$1
GTK_LIGHT_THEME="WhiteSur-Light-alt-pink"
GTK_LIGHT_ICON_THEME="WhiteSur"
KVANTUM_THEME="WhiteSur"
GTK_DARK_THEME="WhiteSur-Dark-alt-pink"
GTK_DARK_ICON_THEME="WhiteSur-dark"
KVANTUM_DARK_THEME="WhiteSurDark"

function setlighttheme() {
  gsettings set org.gnome.desktop.interface gtk-theme $GTK_LIGHT_THEME
  gsettings set org.gnome.desktop.interface icon-theme $GTK_LIGHT_ICON_THEME
  gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
  kvantummanager --set $KVANTUM_THEME > /dev/null 2>&1
}

function setdarktheme() {
  gsettings set org.gnome.desktop.interface gtk-theme $GTK_DARK_THEME
  gsettings set org.gnome.desktop.interface icon-theme $GTK_DARK_ICON_THEME
  gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
  kvantummanager --set $KVANTUM_DARK_THEME > /dev/null 2>&1
}

function switchtheme() {
  DAYORNIGHT=$(sunwait poll 35N 140E)
  if [[ "$DAYORNIGHT" == "DAY" ]]; then
    setlighttheme
  else
    setdarktheme
  fi
}

if [ "$MODE" = "day" ]; then
  setlighttheme
elif [ "$MODE" = "night" ]; then
  setdarktheme
else
  switchtheme
fi
