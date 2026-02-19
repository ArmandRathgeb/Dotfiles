import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.widgets.indicators
import qs.widgets.hypr

Item {
    id: root
    property string backgroundStyle: "opaque"
    property bool enableBlur: false
    property string position: "top"

    signal toggleCalendar()
    signal toggleControlCenter()
    signal toggleUpdateCenter()

    Row { 
        anchors {
            left: parent.left 
            leftMargin: 8
            verticalCenter: parent.verticalCenter
        }
        spacing: 8

        Workspaces { }
        Title {
        }
    }

    BarClock {
        id: clockComponent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        onClicked: root.toggleCalendar()
    }
    Item {
        anchors {
            right: parent.right 
            rightMargin: 8
            verticalCenter: parent.verticalCenter
        } 
        height: parent.height
        implicitWidth: rightRow.implicitWidth
        Row {
            id: rightRow
            anchors.fill: parent
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8
            SysTray {}
            UpdatesIndicator {
                onClicked: root.toggleUpdateCenter()
            }
            Stats {}
            ControlCenterButton {
                id: controlCenterButton
                onToggleControlCenter: root.toggleControlCenter()
            }
        }
    }
}