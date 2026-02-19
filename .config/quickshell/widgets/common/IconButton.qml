import Quickshell
import Quickshell.Widgets
import QtQuick
import qs


Rectangle {
    id: root
    signal clicked()
    property var icon
    color: mouseArea.containsMouse ? Config.theme.accentBlack : "transparent"
    radius: 4

    MouseArea {
        id: mouseArea
        hoverEnabled: enabled
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }

    IconImage {
        source: root.icon
        anchors.fill: parent
    }
}