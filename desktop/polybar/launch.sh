#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar main-monitor-philips
# ln -s /tmp/polybar_mqueue.$! /tmp/ipc-bottom
# if xrandr --listmonitors | grep -q HDMI-1-1; then polybar HDMI; fi
# if xrandr --listmonitors | grep -q DP-1-1; then polybar DP; fi

echo message >/tmp/ipc-bottom
echo "Bars launched..."
