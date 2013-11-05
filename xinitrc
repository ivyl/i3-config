#!/bin/sh

#settings
xset -b
xrdb -merge ~/.i3/xresources

#background
[ -e ~/.fehbg ] && source ~/.fehbg

#hide mouse coursor when it isn't used
unclutter -root -visible &

#clipboard synchronization
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

#dbus instance
eval `dbus-launch --sh-syntax --exit-with-session`

#apps
start-pulseaudio-x11
mpd &
urxvtd &

#keyboard layout
setxkbmap -layout pl
setxkbmap -option ctrl:nocaps
xmodmap ~/.i3/xmodmap
[ -e ~/.xmodmap_local ] && xmodmap ~/.xmodmap_local

#color temperature adjustment, set for Gdańsk
redshift -l 54.35:18.65 -m randr -t 5500:4500 -g 0.75:0.75:0.75 &

#notification
dunst -config ~/.i3/dunstrc &

#disks automounting
udiskie &

#creating gpg agent
GPG_ENVFILE="$HOME/.gnupg/gpg-agent.env"
if [ -x $(which gpg-agent) ]; then
    eval "$(gpg-agent --enable-ssh-support --daemon --write-env-file "$GPG_ENVFILE")"
    export GPG_AGENT_INFO
fi

compton --config ~/.i3/compton.conf &

i3

#getting rid of gpg agent
[ -x $(which gpg-agent) ] && kill $(grep GPG_AGENT_INFO "$GPG_ENVFILE" | cut -d: -f 2) 2>/dev/null

true
