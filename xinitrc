#!/bin/sh

#settings
xset -b
xrdb -merge ~/.i3/xresources

#background
feh --bg-fill ~/.i3/background

#hide mouse coursor when it isn't used
unclutter &

#clipboard synchronization
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

#dbus instance
eval `dbus-launch --sh-syntax --exit-with-session`

#apps
start-pulseaudio-x11 &
urxvtd &

#keyboard layout
setxkbmap -layout pl
xmodmap ~/.i3/xmodmap
[ -e ~/.xmodmap_local ] && xmodmap ~/.xmodmap_local

#notification
dunst -config ~/.i3/dunstrc

#disks automounting
udiskie &

i3
