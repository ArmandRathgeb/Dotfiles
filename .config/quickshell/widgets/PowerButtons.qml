pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts 
import qs
import qs.widgets.common

Rectangle { 
    color: "transparent"
    implicitWidth: column.implicitWidth 
    implicitHeight: column.implicitHeight + 6

    RowLayout {
        id: column
        anchors.centerIn: parent
        spacing: 10

        IconButton {
            id: powerOff 
            icon: Quickshell.iconPath("system-shutdown")
            implicitHeight: 25
            implicitWidth: 25
            border.width: 1
            border.color: "transparent"
            onClicked: {
                Quickshell.execDetached(["systemctl", "poweroff"])
            }
        }
        IconButton {
            icon: Quickshell.iconPath("system-reboot")
            implicitHeight: 25
            implicitWidth: 25
            border.width: 1
            border.color: "transparent"
            onClicked: {
                Quickshell.execDetached(["systemctl", "reboot"])
            }
        }
        IconButton {
            icon: Quickshell.iconPath("lock-symbolic")
            implicitHeight: 25
            implicitWidth: 25
            border.width: 1
            border.color: "transparent"
            onClicked: {
                Quickshell.execDetached(["hyprlock"])
            }
        }
        IconButton {
            icon: Quickshell.iconPath("application-exit-symbolic")
            implicitHeight: 25
            implicitWidth: 25
            border.width: 1
            border.color: "transparent"
            onClicked: {
                Quickshell.execDetached(["hyprctl", "dispatch", "exit"])
            }
        }
    }
}
