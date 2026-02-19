pragma Singleton 

import QtQuick
import Quickshell
import qs.themes

Singleton {
    id: config

    property int workSpacesToShow: 10
    property var theme: Purple
    property alias battery: batteryOptions
    property alias audio: audioOptions

    property int updateFrequencySeconds: 6000 // Once an hour
    property string terminal: "alacritty"
    property string updateCommand: "paru -Syu"
    property string updateCheck: "checkupdates && paru -Qua"

    QtObject {
        id: batteryOptions
        property real low: 20 
        property real critical: 10
        property real suspend: 2
        property real full: 99
        property bool automaticSuspend: true
    }
    QtObject {
        id: audioOptions
        property real hardMaxValue: 2.00
        property bool enableProtection: false
        property real maxAllowed: 99
        property real maxAllowedIncrease: 10
    }
}