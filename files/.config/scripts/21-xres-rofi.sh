#!/bin/bash

BASEDIR="$HOME/.config/rofi"
THEME="$BASEDIR/monokai.rasi"

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
	typeface
	accent
"

for x in $RESOURCES; do
	if [[ $x == "typeface" ]]; then
		xres=$(xrdb -query | awk -v z="global.rofifont:" '$1==z{for (i=2; i<NF; i++) printf $i " "; print $NF}')
		sed -i --follow-symlinks "/$x: /c\\$x: \"$xres\"\;" $THEME
	else
		xres=$(xrdb -query | awk -v z="global.$x:" '$1==z{print $2}')
		sed -i --follow-symlinks "/$x: /c\\$x: $xres\;" $THEME
	fi
done


