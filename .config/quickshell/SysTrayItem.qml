import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray 

MouseArea {
    id: root
    required property SystemTrayItem item 
    property bool targetMenuOpen: false

    signal menuOpened(window: var)
    signal menuClosed()

    implicitHeight: 20
    implicitWidth: 20
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    Component.onCompleted: {
        console.log("System tray", item.title, "completed")
    }

    onEntered: {
        let text = item.tooltipTitle
        if (item.tooltipDescription.length > 0) {
            text += " - " 
            text += item.tooltipDescription
        }
        if (text.length > 0) {
            tooltip.text = text
            console.log(text)
        }
    }

    onPressed: (e) => {
        switch (e.button) {
        case Qt.LeftButton:
            item.activate()
            break
        case Qt.RightButton:
            if (item.hasMenu)
                menu.open(e.x, e.y)
            break
        }
        e.accepted = true
    }

    Loader {
        id: menu 
        function open() {
            menu.active = true
        }
        active: false 
        sourceComponent: SysTrayMenu {
            id: menuComponent
            Component.onCompleted: this.open()
            trayItemMenuHandle: root.item.menu 
            onMenuOpened: (window) => root.menuOpened(window)
            onMenuClosed: {
                root.menuClosed()
                menu.active = false
            }
            anchor {
                item: parent
                rect {
                    height: root.height 
                    width: root.width
                }
                edges: Edges.Top | Edges.Right
                gravity: Edges.Top | Edges.Right
            }
        }
    }

    IconImage {
        id: trayIcon 
        visible: true
        source: root.item.icon
        anchors.centerIn: parent 
        width: parent.width 
        height: parent.height
    }

    ToolTip {
        id: tooltip
        parent: trayIcon
        //visible: root.containsMouse && text.length > 0
        font.family: Config.theme.fontFamily
    }
}