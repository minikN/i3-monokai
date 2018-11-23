#!/bin/bash


SUBLIME="$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"

case "$1" in 
  *spectrum*)
    sed -i --follow-symlinks "/color_scheme/c\\\"color_scheme\": \"Packages/Theme - Monokai Pro/Monokai Pro (Filter Spectrum).tmTheme\"," $SUBLIME
    sed -i --follow-symlinks "/theme/c\\\"theme\": \"Monokai Pro (Filter Spectrum).sublime-theme\"," $SUBLIME
    ;;
  *octagon*)
    sed -i --follow-symlinks "/color_scheme/c\\\"color_scheme\": \"Packages/Theme - Monokai Pro/Monokai Pro (Filter Octagon).tmTheme\"," $SUBLIME
    sed -i --follow-symlinks "/theme/c\\\"theme\": \"Monokai Pro (Filter Octagon).sublime-theme\"," $SUBLIME
    ;;
  *machine*)
    sed -i --follow-symlinks "/color_scheme/c\\\"color_scheme\": \"Packages/Theme - Monokai Pro/Monokai Pro (Filter Machine).tmTheme\"," $SUBLIME
    sed -i --follow-symlinks "/theme/c\\\"theme\": \"Monokai Pro (Filter Machine).sublime-theme\"," $SUBLIME
    ;;
  *ristretto*)
    sed -i --follow-symlinks "/color_scheme/c\\\"color_scheme\": \"Packages/Theme - Monokai Pro/Monokai Pro (Filter Ristretto).tmTheme\"," $SUBLIME
    sed -i --follow-symlinks "/theme/c\\\"theme\": \"Monokai Pro (Filter Ristretto).sublime-theme\"," $SUBLIME
    ;;
  *classic*)
    sed -i --follow-symlinks "/color_scheme/c\\\"color_scheme\": \"Packages/Theme - Monokai Pro/Monokai Classic.tmTheme\"," $SUBLIME
    sed -i --follow-symlinks "/theme/c\\\"theme\": \"Monokai Classic.sublime-theme\"," $SUBLIME
    ;;
  *)
    sed -i --follow-symlinks "/color_scheme/c\\\"color_scheme\": \"Packages/Theme - Monokai Pro/Monokai Pro.tmTheme\"," $SUBLIME
    sed -i --follow-symlinks "/theme/c\\\"theme\": \"Monokai Pro.sublime-theme\"," $SUBLIME
    ;;
esac