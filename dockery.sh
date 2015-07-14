#!/bin/zsh

function both() {
    [ -e ~/.fehbg ] && source ~/.fehbg
}

function undock() {
    xrandr --output DP2 --off
    nmcli radio wifi on

    both
}

function dock() {
    xrandr --output DP2 --right-of LVDS1 --auto
    nmcli radio wwan off

    both

    sleep 2
    pactl set-default-sink alsa_output.usb-FiiO_DigiHug_USB_Audio-01-Audio.analog-stereo
    xinput set-prop "Primax Kensington Eagle Trackball" "Evdev Middle Button Emulation" 1
}


function main() {
    # lsusb | grep 'Mini Dock'

    # if [ $? -eq 0 ]; then
    if [ "$1" = "dock" ]; then
        echo "[dockery] dock plugged"
        dock
    elif [ "$1" = "undock" ]; then
        echo "[dockery] dock unplugged"
        undock
    else
        echo "[dockery] unknown action!"
    fi
}

main $@

