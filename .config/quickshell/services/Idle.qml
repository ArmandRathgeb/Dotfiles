pragma Singleton 
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland 

Singleton {
    id: root 
    property alias inhibit: persist.enabled

    PersistentProperties {
        id: persist 
        property bool enabled: false

        reloadableId: "idleInhibitor"
    }

    IdleInhibitor {
        id: idle 
        enabled: persist.enabled
        window: PanelWindow {
            implicitHeight: 0
            implicitWidth: 0 
            color: "transparent"
            mask: Region {}
        }
    }

    IpcHandler {
        target: "idleInhibitor"

        function isEnabled(): bool {
            return persist.enabled 
        }

        function toggle(): void {
            persist.enabled = !persist.enabled
        }
    }
}