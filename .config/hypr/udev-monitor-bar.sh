#!/bin/bash

EWW=$(which eww)

udevadm monitor --udev | while read -r line; do
    if echo "$line" | grep -q "change"; then 
        monitors=$(hyprctl monitors -j | jq -r '.[].name')
        ${EWW} open bar --screen="${monitors[0]}"
        echo "Eww opened on ${monitors[0]}"
    fi
done
