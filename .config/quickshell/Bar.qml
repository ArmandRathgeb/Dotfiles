import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.widgets.common
import qs.widgets.indicators
import qs.widgets.hypr

Item {
    id: root

    signal toggleAppMenu()
    signal toggleCalendar()
    signal toggleControlCenter()
    signal toggleUpdateCenter()

    Item {
        anchors {
            left: parent.left 
            leftMargin: 8
            verticalCenter: parent.verticalCenter
        }
        height: parent.height
        implicitWidth: leftRow.implicitWidth

        RowLayout { 
            id: leftRow
            spacing: 8
            anchors.fill: parent

            IconButton {
                icon: Quickshell.iconPath("open-menu-symbolic")
                Layout.fillHeight: true
                implicitWidth: 32
                onClicked: toggleAppMenu()
            }

            Workspaces { 
            }
            Title {
                Layout.maximumWidth: 500
            }
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
