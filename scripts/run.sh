#!/bin/sh

feh --bg-fill ~/Wallpapers/big-sur.jpg &
xset r rate 250 80 &
echo "Xft.dpi: 192" | xrdb -merge &
redshift -l 30:-95 &
gwe --hide-window &
picom &

~/.config/chadwm/scripts/bar.sh &
while type dwm >/dev/null; do dwm && continue || break; done
