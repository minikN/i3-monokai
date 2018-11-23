#!/bin/bash

BASEDIR="$HOME/.config/rofi"
SPOTLIGHT="$BASEDIR/spotlight.rasi"
DMENU="$BASEDIR/menu.rasi"
HIGHLIGHT="yellow"

RESOURCES="
	bg
	grey
	grey-dark
	grey-bright
	fg
	fg-dark
	fg-bright
	fg-white
	contrast
	contrast-dark
	contrast-darker
	red
	yellow
	green
	purple
	orange
	cyan
	accent
	highlight
	font-rofi
	mono-rofi
"

for x in $RESOURCES; do
	if [[ $x == "font-rofi" ]]; then
		xres=$(xrdb -query | awk -v z="global.font-rofi:" '$1==z{for (i=2; i<NF; i++) printf $i " "; print $NF}')
		echo "$x: $xres"
		sed -i --follow-symlinks "/$x: /c\\$x: \"$xres\"\;" $SPOTLIGHT
		sed -i --follow-symlinks "/$x: /c\\$x: \"$xres\"\;" $DMENU
	elif [[ $x == "mono-rofi" ]]; then
		xres=$(xrdb -query | awk -v z="global.mono-rofi:" '$1==z{for (i=2; i<NF; i++) printf $i " "; print $NF}')
		echo "$x: $xres"
		sed -i --follow-symlinks "/$x: /c\\$x: \"$xres\"\;" $SPOTLIGHT
		sed -i --follow-symlinks "/$x: /c\\$x: \"$xres\"\;" $DMENU
	elif [[ $x == "highlight" ]]; then
		xres=$(xrdb -query | awk -v z="global.$HIGHLIGHT:" '$1==z{print $2}')
		sed -i --follow-symlinks "/$x: /c\\$x: bold $xres\;" $SPOTLIGHT
		sed -i --follow-symlinks "/$x: /c\\$x: bold $xres\;" $DMENU
	else
		xres=$(xrdb -query | awk -v z="global.$x:" '$1==z{print $2}')
		sed -i --follow-symlinks "/$x: /c\\$x: $xres\;" $SPOTLIGHT
		sed -i --follow-symlinks "/$x: /c\\$x: $xres\;" $DMENU
	fi
done


