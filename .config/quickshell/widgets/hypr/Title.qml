import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import qs

Rectangle {
    id: titleBar

    width: parent.width
    implicitHeight: titleText.implicitHeight
    implicitWidth: titleText.implicitWidth
    color: "transparent"
    clip: true

    property var currentWorkspace: {
        if (Hyprland.focusedWorkspace) {
            return Hyprland.focusedWorkspace
        }
        if (Hyprland.focusedMonitor && Hyprland.focused.activeWorkspace) {
            return Hyprland.focusedMonitor.activeWorkspace
        }
        for (let i = 0; i < Hyprland.monitors.length; i++) {
            if (Hyprland.monitors.values[i].focused && Hyprland.monitors.values[i].activeWorkspace) {
                return Hyprland.monitors.values[i].activeWorkspace
            }
        }
        return null
    }

    Text {
        id: titleText
        width: parent.width
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        color: Config.theme.fgPrimary
        font.family: Config.theme.fontFamily
        font.pixelSize: Config.theme.fontSize
        elide: Text.ElideRight

        text: {
            let tl = Hyprland.activeTopLevel
            let str = ""
            if (tl) {
                str = tl.title
            }
            if (titleBar.currentWorkspace) {
                let tls = titleBar.currentWorkspace.toplevels.values
                for (let i = 0; i < tls.length; i++) {
                    if (tls[i].activated) {
                        str = tls[i].title
                        break
                    }
                }
            }
            return str
        }
    }
}