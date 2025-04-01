#!/bin/bash

status=$(nmcli network connectivity)
if [ "$status" = "full" ]; then
    nmcli networking off
else 
    nmcli networking on
fi
