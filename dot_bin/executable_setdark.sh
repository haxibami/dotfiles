#!/usr/bin/env bash

# a script to switch GTK theme according to time
# requires: gsettings

GTK_DARK_THEME="WhiteSur-Dark-alt-pink"
GTK_DARK_ICON_THEME="WhiteSur-dark"
GTK_DARK_CURSOR_THEME="Bibata-Original-Classic"
KVANTUM_DARK_THEME="WhiteSurDark"
XSETTINGS_CONF="$HOME/.config/xsettingsd/xsettingsd.conf"

function setdarktheme() {
  # GTK
  gsettings set org.gnome.desktop.interface gtk-theme $GTK_DARK_THEME
  gsettings set org.gnome.desktop.interface icon-theme $GTK_DARK_ICON_THEME
  gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
  # QT (kvantum)
  kvantummanager --set $KVANTUM_DARK_THEME > /dev/null 2>&1
  # GTK (XWayland)
  sed -i --follow-symlinks "s:Net/ThemeName .*:Net/ThemeName \"$GTK_DARK_THEME\":g" $XSETTINGS_CONF
  sed -i --follow-symlinks "s:Net/IconThemeName .*:Net/IconThemeName \"$GTK_DARK_ICON_THEME\":g" $XSETTINGS_CONF
  sed -i --follow-symlinks "s:Gtk/CursorThemeName .*:Gtk/CursorThemeName \"$GTK_DARK_CURSOR_THEME\":g" $XSETTINGS_CONF
  if [[ `pidof xsettingsd` ]]; then
    killall -HUP xsettingsd
  else
    xsettingsd &
  fi
}

setdarktheme

notify-send --app-name="darkman" --urgency=low --icon=weather-clear-night "darkman" "switching to dark mode"
