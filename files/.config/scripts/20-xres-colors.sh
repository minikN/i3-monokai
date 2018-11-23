#!/bin/env bash

# Simple script to switch between color palettes.
# It will swap the color palette in .Xresources
# plus the vim colorscheme. If you don't
# want the vim scheme to be changed, 
# delete the vim related section.
#
# by minikN

# Setting the base dir
BASEDIR=$HOME/.config/Xresources
SCRIPTS=$HOME/.config/scripts

# Getting all available color palettes
# You may add your own palette. It has to be in .Xresources format.
# Take a look at https://github.com/chriskempson/base16-xresources
THEME=$((ls $BASEDIR -I COLORS | sed -e 's:\.[^./]*$::') | rofi -dmenu -p "Choose Colorscheme" -theme $1)

# Exit if no theme was selcted
[[ -z "$THEME" ]] && exit

ln -sf $BASEDIR/$THEME.Xresources $BASEDIR/COLORS	
xrdb -load $HOME/.Xresources

# rofi, terminals
sh "$SCRIPTS/21-xres-rofi.sh"
sh "$SCRIPTS/22-xres-terminal.sh"
sh "$SCRIPTS/23-xres-sublime.sh" $THEME

# VIM RELATED
sed -i --follow-symlinks "/colorscheme/c\colorscheme ${THEME%'-256'}" $HOME/.vimrc
source $HOME/.vimrc

# Restarting i3
i3-msg restart 
