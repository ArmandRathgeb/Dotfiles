pragma Singleton 
import QtQuick
import Quickshell
import Quickshell.Wayland 

Singleton {
    id: root 
    property alias inhibit: idle.enabled 
    inhibit: false 

    function toggleInhibit(active = null) {
        if (active !== null) {
            idle.enabled = active
        } else {
            idle.enabled = !idle.enabled
        }
    }

    IdleInhibitor {
        id: idle 
        window: PanelWindow {
            implicitHeight: 0
            implicitWidth: 0 
            color: "transparent"
            anchors {
                right: true 
                bottom: true
            }
            mask: Region {
                item: null
            }
        }
    }
}