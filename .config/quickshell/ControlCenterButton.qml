import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.widgets.indicators

Rectangle {
    id: root 

    property bool controlCenterShown: false

    implicitWidth: rowLayout.implicitWidth + 10
    height: parent.height
    color: mouseArea.containsMouse ? Config.theme.bgSecondary : Config.theme.bgBase
    radius: 6

    signal toggleControlCenter()

    RowLayout {
        id: rowLayout
        spacing: 10
        anchors.centerIn: parent

        VolumeIndicator {}
        BatteryIndicator {}
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