#!/bin/env zsh

# Simple script to switch between color palettes.
# It will swap the color palette in .Xresources
# plus the vim colorscheme. If you don't
# want the vim scheme to be changed, 
# delete the vim related section.
#
# by minikN

# Setting the base dir
BASEDIR=$HOME/.config/Xresources

# Getting all available color palettes
# You may add your own palette. It has to be in .Xresources format.
# Take a look at https://github.com/chriskempson/base16-xresources
THEME=$(echo -e "`ls $BASEDIR -I COLORS | sed -e 's:\.[^./]*$::'`" | rofi -dmenu -i -p "Choose Colorscheme")
if ! [[ -z "$THEME" ]]; then
	ln -sf $BASEDIR/$THEME.Xresources $BASEDIR/COLORS	
	#cat "$BASEDIR/$THEME.Xresources" > $BASEDIR/COLORS
	xrdb -load $HOME/.Xresources

	# VIM RELATED
	sed -i '/colorscheme/d' $HOME/.vimrc
	sed -i '$d' $HOME/.vimrc
	echo "\ncolorscheme ${THEME%"-256"}" >> $HOME/.vimrc
	# DELETE UNTIL HERE IF YOU DON'T WANT ANY CHANGES TO YOUR VIMRC.

	# Restarting i3
	i3-msg restart 
fi
