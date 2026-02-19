import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services

Rectangle {
    id: root 

    radius: 6

    color: mouseArea.containsMouse ? Config.theme.bgSecondary : Config.theme.bgBase
    height: parent.height
    implicitWidth: content.implicitWidth + 20

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
            Text {
                text: `💾  ${RAM.ramPercent}%`
                font.pixelSize: Config.theme.fontSize 
                font.family: Config.theme.fontFamily
                color: Config.theme.fgPrimary
            }
            Text {
                text: `  ${CPU.cpuLoadPercent}%`
                font.family: Config.theme.fontFamily
                font.pixelSize: Config.theme.fontSize
                color: Config.theme.fgPrimary
            }
            Text {
                text: ` / ${Disk.percentUsed}%`
                font.family: Config.theme.fontFamily
                font.pixelSize: Config.theme.fontSize
                color: Config.theme.fgPrimary
            }
        }
    }

    MouseArea {
        id: mouseArea 
        anchors.fill: parent

        cursorShape: Qt.PointingHandCursor 
        hoverEnabled: true

        onClicked: {

        }
    }
}