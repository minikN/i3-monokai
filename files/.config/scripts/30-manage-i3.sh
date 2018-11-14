#!/bin/env bash

# Simple script to shutdown / restart / ...
# by minikN

# Setting the base dir
SCRIPTS=$HOME/.config/scripts

# Getting all available color palettes
# You may add your own palette. It has to be in .Xresources format.
# Take a look at https://github.com/chriskempson/base16-xresources
ACTION=$(echo -e "SHUTDOWN\nRESTART\nSLEEP\nCLOSE WM\nRELOAD WM" | rofi -dmenu -p "What do you want to do?" -theme $1)

# Exit if no theme was selcted
[[ -z "$ACTION" ]] && exit
echo $ACTION;

case $ACTION in
	"SHUTDOWN") systemctl poweroff
	;;
	"RESTART") systemctl reboot
	;;
	"SLEEP") systemctl suspend
	;;
	"CLOSE WM") i3-msg exit
	;;
	"RELOAD WM") i3-msg restart
esac

exit
