#!/bin/bash

# Loading layouts
BASEDIR="$HOME/.config/i3"

# CODE layout
i3-msg "workspace CODE; append_layout $BASEDIR/code.json"