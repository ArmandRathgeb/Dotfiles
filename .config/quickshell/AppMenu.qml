import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell 
import qs.widgets.common

Item {
    id: root
    implicitHeight: 400
    implicitWidth: 300

    signal closeMenu()

    Rectangle {
        id: rect
        color: Config.theme.bgBase
        radius: 20
        anchors.fill: parent
        layer.enabled: true
        opacity: 0

        clip: true

        ColumnLayout {
            anchors.fill: parent 
            anchors.margins: parent.border.width
            Search {
                id: searchBox
                Layout.fillWidth: true 
                implicitHeight: 40
                radius: 20
                searchSpace: DesktopEntries.applications.values 
                heuristic: (query, entry) => {
                    return entry.name.toLowerCase().includes(query)
                        || entry.execString.toLowerCase().includes(query)
                }
            }

            ScrollView {
                Layout.fillWidth: true 
                Layout.fillHeight: true
                spacing: 0
                clip: true

                ListView {
                    id: listView
                    anchors.fill: parent 
                    model: searchBox.resultsModel
                    clip: true

                    delegate: ItemDelegate {
                        id: control 
                        width: listView.width
                        contentItem: RoundedButton {
                            radius: 0
                            imageIcon: Quickshell.iconPath(entry.icon)
                            text: entry.name
                            onClicked: {
                                modelData.execute()
                                root.closeMenu()
                            }
                            hoverEnabled: true
                            StyledTooltip {
                                visible: hovered && entry.comment !== ""
                                text: entry.comment
                            }
                        }
                        background: Rectangle{ color: "transparent" }
                    }
                }
            }
        }
    }

    // All this so that ListView doesn't clip over the edge
    MultiEffect {
        source: rect
        anchors.fill: rect
        maskEnabled: true
        maskSource: mask
        maskThresholdMin: 0.5
        maskSpreadAtMin: 1.0
    }
    Item {
        id: mask
        width: rect.width
        height: rect.height
        layer.enabled: true
        visible: false
        // Define the rounded mask shape
        Rectangle {
            anchors.fill: parent
            radius: rect.radius
            color: "black"
        }
    }
}