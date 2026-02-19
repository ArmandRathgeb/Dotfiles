import QtQuick
import Quickshell
import qs
import qs.services

Rectangle {
    id: root

    implicitWidth: clockText.width + 40
    implicitHeight: parent.height
    
    color: mouseArea.containsMouse ? Config.theme.bgSecondary : Config.theme.bgBase
    radius: 6

    signal clicked()

    Text {
        id: clockText 
        anchors.centerIn: parent 
        text: Time.timeAndDate
        color: Config.theme.fgPrimary
        font.family: Config.theme.fontFamily
        font.pixelSize: Config.theme.fontSize
    }

    MouseArea {
        id: mouseArea 
        anchors.fill: parent 
        hoverEnabled: true 
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            root.clicked()
        }
    }
}