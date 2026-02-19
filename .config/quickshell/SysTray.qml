import QtQuick 
import QtQuick.Layouts 
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Services.SystemTray

Rectangle {
    id: root 
    property var activeMenu: null

    height: parent.height
    implicitWidth: layout.implicitWidth
    radius: 2

    color: "transparent"// Config.theme.accentWhite

    HyprlandFocusGrab {
        id: focusGrab
        active: false 
        windows: [root.activeMenu]
        onCleared: {
            if (root.activeMenu) {
                root.activeMenu.close()
                root.activeMenu = null
            }
        }
    }


    RowLayout {
        id: layout
        anchors.fill: parent
        spacing: 5

        Repeater {
            model: ScriptModel {
                values: SystemTray.items.values
            }
            delegate: SysTrayItem {
                required property SystemTrayItem modelData
                item: modelData

                Layout.fillHeight: true 
                Layout.fillWidth: false
                onMenuClosed: focusGrab.active = false 
                onMenuOpened: (window) => {
                    root.activeMenu = window 
                    focusGrab.active = true
                }
            }
        }
    }
}
//*/