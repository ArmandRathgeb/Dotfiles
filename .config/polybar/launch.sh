#!/usr/bin/env bash

killall -q polybar

polybar mybar 2>&1 & disown
#polybar mybar1 2>&1 & disown
