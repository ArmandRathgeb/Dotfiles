pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services

Rectangle {
    id: root 

    radius: 6

    //color: mouseArea.containsMouse ? Config.theme.bgSecondary : Config.theme.bgBase
    color: Config.theme.bgBase
    height: parent.height
    implicitWidth: text.implicitWidth + 20
    Text {
        id: text
        anchors.centerIn: parent
        text: `💾  ${RAM.ramPercent}%   ${CPU.cpuLoadPercent}%   / ${Disk.percentUsed}%`
        font.pixelSize: Config.theme.fontSize 
        font.family: Config.theme.fontFamily
        color: Config.theme.fgPrimary
    }

    /*
    MouseArea {
        id: mouseArea 
        anchors.fill: parent

        cursorShape: Qt.PointingHandCursor 
        hoverEnabled: true

        onClicked: {

        }
    }
    */
}