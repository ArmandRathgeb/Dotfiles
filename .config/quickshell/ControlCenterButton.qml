import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.widgets.indicators

Rectangle {
    id: root 

    property bool controlCenterShown: false

    implicitWidth: content.implicitWidth + 10
    height: parent.height
    color: mouseArea.containsMouse ? Config.theme.bgSecondary : Config.theme.bgBase
    radius: 6

    signal toggleControlCenter()

    Rectangle {
        id: content 

        anchors.centerIn: parent 
        implicitWidth: rowLayout.width 
        implicitHeight: rowLayout.height

        radius: 6
        color: "transparent"

        RowLayout {
            id: rowLayout
            spacing: 10
            VolumeIndicator {}
            BatteryIndicator {}
        }
    }
    MouseArea {
        id: mouseArea 
        anchors.fill: parent

        cursorShape: Qt.PointingHandCursor 
        hoverEnabled: true

        onClicked: {
            root.toggleControlCenter()
            root.controlCenterShown = !root.controlCenterShown
        }
    }
}