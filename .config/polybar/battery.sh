#!/bin/bash

BAT=/sys/class/power_supply/BAT0

bat_level=$(cat "$BAT/energy_now")
bat_max=$(cat "$BAT/energy_full")

bat_percent=$(("bat_level*100/bat_max"))

if [ "$bat_percent" -lt 20 ]; then
    dunstify "Low battery"
fi
