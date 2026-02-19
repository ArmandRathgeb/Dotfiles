import Quickshell
import QtQuick
import QtQuick.Controls 
import QtQuick.Layouts
import qs.services
import qs.widgets.common

Rectangle {
    id: root
    color: Config.theme.bgBase
    implicitHeight: 200
    implicitWidth: 200
    radius: 20
    border.width: 1 
    border.color: Config.theme.surface0

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: parent.border.width
        RoundedButton {
            imageIcon: "image://icon/download"
            text: "Update"
            Layout.fillWidth: true
            onClicked: Updates.update()
            bottomLeftRadius: 0
            bottomRightRadius: 0
        }
        ScrollView {
            id: scrollView
            clip: true
            Layout.fillWidth: true 
            Layout.fillHeight: true

            ListView {
                anchors.centerIn: parent 
                model: Updates.numUpdates
                delegate: ItemDelegate {
                    id: control
                    required property int index
                    text: Updates.toUpdate[index]
                    contentItem: Text {
                        text: control.text
                        font.family: Config.theme.fontFamily
                        font.pixelSize: Config.theme.fontSize
                        color: Config.theme.fgPrimary
                    }
                    background: Rectangle{ color: "transparent" }
    
                }
            }
        }
    }
}