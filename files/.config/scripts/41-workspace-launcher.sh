#!/bin/env bash

# Script to start all applications
# assigned to a specific layout.
# by minikN

# Setting the base dir
BASEDIR="$HOME/.config/i3"
SCRIPTS=$HOME/.config/scripts
TERMINAL=$(xrdb -query | awk -v z="st.title:" '$1==z{print $2}')
TERM_FONT=$(xrdb -query | awk -v z="st.font:" '$1==z{for (i=2; i<NF; i++) printf $i " "; print $NF}')

# Choosing a layout to load
WS=$(echo -e "CODE\n" | rofi -dmenu -p "Choose Workspace" -theme $1)
echo "$TERM_FONT"
# Loading it
[[ -z "$WS" ]] && exit

case $WS in
	"CODE")
	i3-msg "workspace CODE; append_layout $BASEDIR/code.json"
	i3-msg exec "$TERMINAL -n CODE_TERM_1 -f \"$TERM_FONT\""
	i3-msg exec "$TERMINAL -n CODE_TERM_2 -f \"$TERM_FONT\""
	
	subl3
	;;
esac 
