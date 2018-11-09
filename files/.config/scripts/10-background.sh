#!/bin/env zsh

# Simple script to randomize between dual monitor
# wallpapers and two single monitor wallpapers.
#
# This script assumes a 'single' and a 'dual'
# folder in the BASEDIR.
#
# Dual wallpapers are required in full dimensions.
# If you have two 2560x1440 monitors, the wallpaper
# should be 5120x1440.
#
# if you only have one path for wallpapers
# simply disable this script in your i3 config
# and add the feh command there directly.
#
# by minikN

# Setting the base dir
BASEDIR=$HOME/.config/backgrounds

# Setting a random number between 1 and the number of directories inside 'single'
FOLDERS=$((( RANDOM % `find $BASEDIR/single/* -maxdepth 0 -type d | wc -l`) + 1))

# Getting random number between 1 and 2
# 1 = two single wallpapers
# 2 = one dual wallpaper
if [[ $((( RANDOM % 2 ) +1 )) == 1  ]]; then
	COUNTER=1

	# looping thru each folder inside 'single'
	# until we find the folder matching $FOLDERS
	# (basically randmonly selecting a folder)
	for dir in $BASEDIR/single/*; do
		if [[ $FOLDERS == $COUNTER ]]; then
			feh  --recursive --randomize --bg-fill $dir/*
			exit 0
		fi
		COUNTER=$((COUNTER + 1))
	done
else
	feh --recursive --randomize --bg-scale --no-xinerama $BASEDIR/dual/*
fi
