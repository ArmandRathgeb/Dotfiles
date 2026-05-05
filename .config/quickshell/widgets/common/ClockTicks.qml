import QtQuick
import Quickshell
import qs

Rectangle {
    id: root 
    color: "transparent"

    required property int numTicks
    required property real radius 
    required property real x0 
    required property real y0 

    property int tickSize: 3
    property color tickColor: Config.theme.accentWhite

    property int numShown: 0

    onNumShownChanged: {
        for (var i = 0; i < numShown; ++i) {
            ticks[i].visible = true
        }
        for (var i = numShown; i < numTicks; ++i) {
            ticks[i].visible = false
        }
    }

    property list<QtObject> ticks: []
    
    Component.onCompleted: {
        var angStep = (2 * Math.PI) / (root.numTicks - 1)
        for (var i = 0; i < root.numTicks; ++i) {
            var ang = angStep * i - (Math.PI / 2)
            var x = root.x0 + root.radius * Math.cos(ang)
            var y = root.y0 + root.radius * Math.sin(ang)
            root.ticks.push(
                tickComponent.createObject(root, {
                    "x": x,
                    "y": y,
                    visible: false
                })
            )
        }
    }

    Component {
        id: tickComponent
        Rectangle {
            radius: root.tickSize
            color: root.tickColor
            width: radius 
            height: radius
        }
    }
}