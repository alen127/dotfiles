#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar on each monitor, tray on primary
polybar --list-monitors | while IFS=$'\n' read line; do
  monitor=$(echo $line | cut -d':' -f1)
  # if monitor is listed as HDMI-* set primary variable
  primary=$(echo $line | grep HDMI | cut -d ':' -f1)
  MONITOR=$monitor polybar --reload "alen${primary:+"-primary"}" &
done
