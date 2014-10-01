#!/bin/zsh

FIFO=/tmp/dockery


function both() {
    sleep 1
    xset -b
}

function undock() {
    both
	xrandr --output HDMI2 --off
    pacmd set-sink-port alsa_output.pci-0000_00_1b.0.analog-stereo analog-output-speaker
    nmcli r wifi on
}

function dock() {
    both
	xrandr --output HDMI2 --right-of LVDS1 --auto
    pacmd set-sink-port alsa_output.pci-0000_00_1b.0.analog-stereo analog-output
    nmcli r wifi off
}


function main() {
    rm $FIFO
    mkfifo $FIFO

    if [ ! -p $FIFO ]; then
        >&2 echo "[dockery] $FIFO is not a pipe"
        exit 1
    fi

    local cmd
    while true; do
        read -r cmd < $FIFO
        echo "[dockery] command: $cmd"

        case $cmd in
            dock)   dock;;
            undock) undock;;
            *) >&2 echo "[dockery] unknown command"
        esac
    done

    rm $FIFO
}

main

