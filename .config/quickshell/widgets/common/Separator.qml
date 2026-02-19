import QtQuick

Item {
    id: root
    property string text: "|"

    implicitHeight: textSep.height
    implicitWidth: textSep.width
    Text {
        id: textSep
        anchors.centerIn: parent 
        text: root.text
        font.pixelSize: 12
    }
}