#!/bin/bash

EWW=$(which eww)

udevadm monitor --udev | while read -r line; do
    if echo "$line" | grep -q "add"; then 
        if [ "$(${EWW} active-windows | grep "bar" | wc -l)" = 0 ]; then
            ${EWW} open bar
            echo "Eww reopened"
        fi
    fi
done
