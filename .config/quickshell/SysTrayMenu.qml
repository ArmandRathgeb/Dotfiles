import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.widgets.common

PopupWindow {
    id: root 
    required property QsMenuHandle trayItemMenuHandle
    property real padding: 2

    signal menuClosed
    signal menuOpened(window: var)

    color: "transparent"

    implicitHeight: {
        return stackView.currentItem.implicitHeight 
            + root.padding * 2
            + popupBackground.padding * 2
    }
    implicitWidth: {
        let result = 0
        for (let child of stackView.children)
            result = Math.max(child.implicitWidth, result)
        return result + root.padding * 2 + popupBackground.padding * 2
    }

    function open() {
        root.visible = true 
        root.menuOpened(root)
    }

    function close() {
        root.visible = false
        while (stackView.depth > 1)
            stackView.pop()
        root.menuClosed()
    }


    MouseArea {
        anchors.fill: parent 
        acceptedButtons: Qt.BackButton | Qt.RightButton

        onPressed: (e) => {
            if ((e.button === Qt.BackButton || e.button === Qt.RightButton) && stackView.depth > 1)
                stackView.pop()
        }
        Rectangle {
            id: popupBackground
            readonly property real padding: 4
            anchors {
                left: parent.left 
                right: parent.right 
                verticalCenter: parent.verticalCenter
                top: parent.top
                margins: root.padding
            }
            color: Config.theme.bgBase
            radius: 6
            border.width: 1
            border.color: Config.theme.surface1
            clip: true
            implicitHeight: stackView.implicitHeight + popupBackground.padding * 2 
            implicitWidth: stackView.implicitWidth + popupBackground.padding * 2

            StackView {
                id: stackView
                anchors.fill: parent 
                anchors.margins: popupBackground.padding
                implicitWidth: currentItem.implicitWidth
                implicitHeight: currentItem.implicitHeight

                initialItem: SubMenu {
                    handle: root.trayItemMenuHandle
                }
            }
        }
    }
    
    component SubMenu: ColumnLayout {
        id: submenu 
        required property QsMenuHandle handle
        property bool isSubMenu: false 
        property bool shown: false
        opacity: shown ? 1 : 0

        Component.onCompleted: shown = true 
        StackView.onActivating: shown = true 
        StackView.onDeactivating: shown = true 
        StackView.onRemoved: destroy()

        QsMenuOpener {
            id: menuOpener 
            menu: submenu.handle
        }
        spacing: 0

        Loader {
            Layout.fillWidth: true 
            visible: submenu.isSubMenu 
            active: visible 
            sourceComponent: RoundedButton {
                id: backButton
                onClicked: stackView.pop()
                imageIcon: "image://icon/handle-left"
                text: "Back"
                radius: popupBackground.radius - popupBackground.padding
                implicitHeight: 36
            }
        }

        Repeater {
            id: menuEntriesRepeater
            property bool iconColumnNeeded: {
                for (let i = 0; i < menuOpener.children.values.length; i++) {
                    if (menuOpener.children.values[i].icon.length > 0)
                        return true
                }
                return false
            }
            property bool specialInteractionColumnNeeded: {
                for (let i = 0; i < menuOpener.children.values.length; i++) {
                    if (menuOpener.children.values[i].buttonType !== QsMenuButtonType.None)
                        return true
                }
                return false
            }
            model: menuOpener.children
            delegate: SysTrayMenuItem {
                required property QsMenuEntry modelData
                forceIconColumn: menuEntriesRepeater.iconColumnNeeded
                forceSpecialInteractionColumn: menuEntriesRepeater.specialInteractionColumnNeeded
                menuEntry: modelData

                ///buttonRadius: popupBackground.radius - popupBackground.padding

                onDismiss: root.close()
                onOpenSubmenu: handle => {
                    stackView.push(subMenuComponent.createObject(null, {
                        handle: handle,
                        isSubMenu: true
                    }))
                }
            }
        }
    }
    Component { 
        id: subMenuComponent
        SubMenu {}
    }
}