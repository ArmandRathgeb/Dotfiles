import QtQuick
import QtQuick.Layouts 
import Quickshell
import Quickshell.Hyprland
import qs

Item {
    id: root 
    property int workspacesShown: Config.workSpacesToShow

    implicitHeight: workspaces.implicitHeight
    implicitWidth: workspaces.implicitWidth
    WheelHandler {
        onWheel: (event) => {
            if (event.angleDelta.y < 0) 
                Hyprland.dispatch(`workspace r+1`)
            else if (event.angleDelta.y > 0)
                Hyprland.dispatch(`workspace r-1`)
        }
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
        dragThreshold: 1500
    }

    property list<bool> workspaceOccupied: []

    function updateWorkspaceOccupied() {
        workspaceOccupied = Array.from(
            {length: root.workspacesShown},
            (_,i) => {
                return Hyprland.workspaces.values.some(
                    ws => ws.id === i + 1
                )
            }
        )
    }

    Component.onCompleted: updateWorkspaceOccupied()
    Connections {
        target: Hyprland.workspaces 
        function onValuesChanged() {
            updateWorkspaceOccupied();
        }
    }
    Connections {
        target: Hyprland
        function onFocusedWorkspaceChanged() {
            updateWorkspaceOccupied();
        }
    }

    Row {
        id: workspaces
        spacing: 4

        Repeater {
            model: Math.max(root.workspacesShown, Hyprland.workspaces.values.length)
            MouseArea {
                id: workspaceButton 

                implicitWidth: workspaceRect.implicitWidth
                implicitHeight: workspaceRect.implicitHeight


                property int currentWidth: 30
                property int normalWidth: 16

                hoverEnabled: true 
                enabled: true 
                cursorShape: Qt.PointingHandCursor
                z: 10

                Layout.preferredWidth: workspaceRect.isCurrentWorkspace ? currentWidth : normalWidth

                property int workspaceID: index + 1
                property var hyprWorkspace: {
                    for (let i = 0; i < Hyprland.workspaces.values.length; i++) {
                        let ws = Hyprland.workspaces.values[i]
                        if (ws && ws.id === workspaceID) {
                            return Hyprland.workspaces.values[i]
                        }
                    }
                    return null
                }
                Rectangle {
                    id: workspaceRect
                    anchors.centerIn: parent 
                    
                    property bool isCurrentWorkspace: {
                        let ws = workspaceButton.hyprWorkspace 
                        if (ws && (ws.focused || ws.active)) {
                            return true
                        }
                        if (Hyprland.focusedMonitor && Hyprland.focusedMonitor.activeWorkspace) {
                            return Hyprland.focusedMonitor.activeWorkspace.id === workspaceButton.workspaceID
                        }
                        return false
                    }

                    implicitWidth: isCurrentWorkspace ? workspaceButton.currentWidth : workspaceButton.normalWidth
                    implicitHeight: workspaceButton.normalWidth

                    radius: workspaceButton.normalWidth / 2.0

                    color: {
                        let ws = workspaceButton.hyprWorkspace
                        if (ws && ws.urgent) {
                            return Config.theme.accentRed
                        }
                        if (workspaceButton.containsMouse) {
                            return Config.theme.surface1
                        }
                        if (root.workspaceOccupied[workspaceButton.workspaceID - 1]) {
                            return Config.theme.surface0
                        }
                        return Config.theme.bgBase
                    }
                    border.color: Config.theme.surface0
                }

                Text {
                    id: workspaceText
                    anchors.centerIn: workspaceRect
                    text: workspaceButton.workspaceID.toString()
                    font.family: Config.theme.fontFamily
                    font.pixelSize: 10
                    color: {
                        if (workspaceButton.containsMouse || !root.workspaceOccupied[workspaceButton.workspaceID-1])
                            return Config.theme.fgPrimary
                        return Config.theme.bgBase
                    }
                }

                onClicked: {
                    Hyprland.dispatch("workspace %1".arg(workspaceButton.workspaceID))
                }
            }

        }
    }
}