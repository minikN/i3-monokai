#!/bin/bash

RESOURCES="
color0
color1
color2
color3
color4
color5
color6
color7
color8
color9
color10
color11
color12
color13
color14
color15
color16
color17
color18
color19
color20
color21
color255
color256
color257
"

for file in /dev/pts/[0-9]*; do
	for x in $RESOURCES; do
		COLOR=$(xrdb -query | awk -v z="*$x:" '$1==z{print $2}')
		NUMBER=${x##*r}

		case $NUMBER in
			255)
				COLOR=$(xrdb -query | awk -v z="*color0:" '$1==z{print $2}')
			;;
			256)
				COLOR=$(xrdb -query | awk -v z="*color7:" '$1==z{print $2}')
			;;
			257)
				COLOR=$(xrdb -query | awk -v z="*color0:" '$1==z{print $2}')
			;;
		esac
		echo -e -n "\033]4;$NUMBER;$COLOR\033\\\\" > $file
	done
done