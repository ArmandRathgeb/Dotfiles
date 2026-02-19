import Quickshell
import QtQuick
import qs.services
import qs

Rectangle {
    id: root

    implicitHeight: bat.height 
    implicitWidth: bat.width

    color: "transparent"

    Text {
        id: bat
        text: {
            if (!Battery.available) 
                return "󰂃"
            let batstr = ""
            if (Battery.isPluggedIn) {
                if (Battery.percentage <= .1) batstr = "󰢜"
                if (Battery.percentage <= .2) batstr = "󰂆"
                if (Battery.percentage <= .3) batstr = "󰂇"
                if (Battery.percentage <= .4) batstr = "󰂈"
                if (Battery.percentage <= .5) batstr = "󰢝"
                if (Battery.percentage <= .6) batstr = "󰂉"
                if (Battery.percentage <= .7) batstr = "󰢞"
                if (Battery.percentage <= .8) batstr = "󰂊"
                if (Battery.percentage <= .9) batstr = "󰂋"
                if (Battery.percentage <= 1)  batstr = "󰂅"
                return batstr + "  %1%".arg(Battery.percentage * 100)
            }
            else {
                if (Battery.percentage <= .1) batstr = "󰁺"
                if (Battery.percentage <= .2) batstr = "󰁻"
                if (Battery.percentage <= .3) batstr = "󰁼"
                if (Battery.percentage <= .4) batstr = "󰁽"
                if (Battery.percentage <= .5) batstr = "󰁾"
                if (Battery.percentage <= .6) batstr = "󰁿"
                if (Battery.percentage <= .7) batstr = "󰂀"
                if (Battery.percentage <= .8) batstr = "󰂁"
                if (Battery.percentage <= .9) batstr = "󰂂"
                if (Battery.percentage <= 1)  batstr = "󰁹"
                return batstr + " %1%".arg(Battery.percentage * 100)
            }
            return "󰂃"
        }
        color: {
            if (!Battery.available) 
                return Config.theme.accentRed
            if (Battery.isCritical)
                return Config.theme.accentRed
            if (Battery.isLow) 
                return Config.theme.accentYellow
           if (Battery.isFull) 
                return Config.theme.accentGreen
            return Config.theme.fgPrimary
        }
        font.family: Config.theme.fontFamily
        font.pixelSize: 14
    } 
}