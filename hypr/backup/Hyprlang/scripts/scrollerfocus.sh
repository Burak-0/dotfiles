#!/bin/bash
STATE_FILE="/tmp/focus_fit_method"
current=$(cat "$STATE_FILE" 2>/dev/null || echo "1")
if [ "$current" = "1" ]; then
  hyprctl keyword scrolling:focus_fit_method 0
  echo "0" >"$STATE_FILE"
  hyprctl dispatch focuswindow address:$(hyprctl activewindow -j | jq -r '.address')
else
  hyprctl keyword scrolling:focus_fit_method 1
  echo "1" >"$STATE_FILE"
  hyprctl dispatch movefocus u
  hyprctl dispatch movefocus d
fi
