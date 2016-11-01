# My very own i3 Configuration

## Requirements
### general
* i3 - window manager
* i3status - status bar
* feh - setting bg, also nice image viewer
* urxvt - terminal emulator
* unclutter - autohide mouse cursor
* udiskie - device automounting
* dunst - notifications
* pulseaudio - audio managment
* autocutsel - clipboard synchroniation
* dmenu - Super-P launcher
* pavucontrol - pulseaudio mixer
* alsamixer
### from xorg
* setxkbmap - setting keyboard layout
* xmodmap - custom key changes


## Installation
It's as simple as that:

```bash
cd
git clone https://github.com/ivyl/i3-config.git .config/i3
ln -s .config/i3/xinitrc .xinitrc
ln -s .config/i3/gtkrc-2.0 .gtkrc-2.0
ln -f .config/i3/gtk-3.0-settings ~/.config/gtk-3.0/settings.ini
```

## Additional Features
Udev folder contains udev rules and executables to be put under /opt

config is created from config.base and config.local to allow for
per-machine configuration


## Bindings
* Super-Shift-c - close current windows
* Super-Shift-Enter - open terminal
* Super - drag floating windows
* Super-t - toggle floating mode
* Super-f - fullscreen
* Super-r - resize mode
* Super-d - parent container - dad
* Super-b - child container - baby

Check config for more.
