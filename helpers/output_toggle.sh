#!/bin/sh

OUTPUT="$1"

if [ -z "$OUTPUT" ]; then
    echo "$0 OUTPUT_NAME"
    exit 1
fi

IS_ENABLED=$(swaymsg -t get_outputs | jq ".[] | select(.name == \"$OUTPUT\") | .active")

if [ "$IS_ENABLED" == "true" ]; then
    swaymsg output $OUTPUT disable
else
    swaymsg output $OUTPUT enable
fi
