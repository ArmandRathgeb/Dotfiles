pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs 
import qs.services
import qs.widgets.common

Tile {
    id: root

    property real center_x: this.width / 2
    property real center_y: this.height / 2

    Rectangle {
        x: 100
        y: 100
        anchors.centerIn: parent
        Text {
            id: timeText
            text: Time.timeWithSec
            anchors.centerIn: parent
            color: Config.theme.surface0
            font.pixelSize: 13
        }
    }
    ClockTicks {
        id: secondsTicks
        anchors.fill: parent
        numTicks: 60 
        radius: 90
        x0: center_x
        y0: center_y
        numShown: Time.seconds
    }

    ClockTicks {
        id: minutesTicks
        anchors.fill: parent 
        numTicks: 60 
        radius: 70
        x0: center_x
        y0: center_y
        numShown: Time.minutes
    }
    
    ClockTicks {
        id: hoursTicks
        anchors.fill: parent 
        numTicks: 24 
        radius: 50 
        x0: center_x
        y0: center_y
        numShown: Time.hours
    }
}