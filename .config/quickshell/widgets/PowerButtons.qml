import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts 
import qs
import qs.widgets.common

Rectangle { 
    color: "transparent"
    implicitWidth: column.implicitWidth + 10
    implicitHeight: column.implicitHeight + 6
    border.width: 1
    border.color: Config.theme.accentMagenta
    radius: 5

    ColumnLayout {
        id: column
        anchors.centerIn: parent
        Process {
            id: powerManagement
        }
        IconButton {
            id: powerOff 
            icon: "image://icon/system-shutdown"
            implicitHeight: 25
            implicitWidth: 25
            border.width: 1
            border.color: "transparent"
            onClicked: {
                powerManagement.exec(["systemctl", "poweroff"])
            }
        }
        IconButton {
            icon: "image://icon/system-reboot"
            implicitHeight: 25
            implicitWidth: 25
            border.width: 1
            border.color: "transparent"
            onClicked: {
                powerManagement.exec(["systemctl", "reboot"])
            }
        }
        IconButton {
            icon: "image://icon/lock-symbolic"
            implicitHeight: 25
            implicitWidth: 25
            border.width: 1
            border.color: "transparent"
            onClicked: {
                powerManagement.exec(["hyprlock"])
            }
        }
        IconButton {
            icon: "image://icon/application-exit-symbolic"
            implicitHeight: 25
            implicitWidth: 25
            border.width: 1
            border.color: "transparent"
            onClicked: {
                powerManagement.exec(["hyprshutdown"])
            }
        }
    }
}