#!/bin/sh
ACPI="$(acpi -b)"
if  echo $ACPI | grep -q Charging; then
    echo ^
elif echo $ACPI | grep -q Discharging; then
    echo v
fi

