import Quickshell
import QtQuick
import qs 
import qs.widgets.common

Tile {
    id: root

    property real center_x: this.width / 2
    property real center_y: this.height / 2

    property list<var> secondsTicks
    property list<var> minutesTicks 
    property list<var> hoursTicks 

    Timer {
        interval: 100 
        running: true 
        repeat: true 
        onTriggered: timeChanged()
    }

    function timeChanged() {
        var date = new Date
        secondsTicks.numShown = date.getSeconds()
        minutesTicks.numShown = date.getMinutes()
        hoursTicks.numShown   = date.getHours()
        timeText.text = date.toTimeString()
    }

    Rectangle {
        x: 100
        y: 100
        anchors.centerIn: parent
        Text {
            id: timeText
            text: "Time"
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
    }

    ClockTicks {
        id: minutesTicks
        anchors.fill: parent 
        numTicks: 60 
        radius: 70
        x0: center_x
        y0: center_y
    }
    
    ClockTicks {
        id: hoursTicks
        anchors.fill: parent 
        numTicks: 24 
        radius: 50 
        x0: center_x
        y0: center_y
    }
}