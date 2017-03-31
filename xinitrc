#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

export I3_CONFIG_DIR="$(dirname $(readlink -f $0))"

export PATH="$PATH:$I3_CONFIG_DIR/bin:$HOME/bin-priv:$HOME/bin"

export MOZ_USE_OMTC=1

# use xresources
xrdb -merge $I3_CONFIG_DIR/xresources

# multiple screen setup
[ -e $I3_CONFIG_DIR/screen_setup ] && source $I3_CONFIG_DIR/screen_setup

# background
[ -e ~/.fehbg ] && source ~/.fehbg

# hide mouse coursor when it isn't used
unclutter -root -visible &

# pulse audio session
start-pulseaudio-x11

# keyboard layout customization
xmodmap $I3_CONFIG_DIR/xmodmap
[ -e $I3_CONFIG_DIR/xmodmap_local ] && xmodmap $I3_CONFIG_DIR/xmodmap_local

# dynamic color temperature adjustment
if [ -e $I3_CONFIG_DIR/redshift ]; then
    source $I3_CONFIG_DIR/redshift
else # default setup, for gdansk
    redshift -l 54.35:18.65 -m randr -t 5500:4500 -g 0.75:0.75:0.75 &
fi

# notification
dunst -config $I3_CONFIG_DIR/dunstrc &

# disks automounting
udiskie &

# trackball
xinput set-prop "Primax Kensington Eagle Trackball" "Evdev Middle Button Emulation" 1

# gpg agent
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
gpg-connect-agent updatestartuptty /bye

# composition manager
compton --config $I3_CONFIG_DIR/compton.conf &

# Network Manager applet
>> /dev/null which nm-applet && nm-applet &
>> /dev/null which blueman-applet && blueman-applet &

i3-regenerate
i3
