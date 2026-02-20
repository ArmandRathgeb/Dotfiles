import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs

Button {
    id: root 

    property var fgColor: Config.theme.fgPrimary
    property var color: mouseArea.containsMouse ? Config.theme.bgSecondary : Config.theme.bgBase
    property string imageIcon
    property string textIcon 
    property bool placeIconRight: false 
    property real radius: 20
    property real bottomRightRadius: radius
    property real bottomLeftRadius: radius

    implicitHeight: contentItem.implicitHeight + 30

    property Component mainContentComponent: Component {
        Text {
            visible: text !== ""
            text: root.text 
            color: root.fgColor
            font.pixelSize: Config.theme.fontSize 
            font.family: Config.theme.fontFamily
        }
    }

    background: Rectangle {
        radius: root.radius
        bottomLeftRadius: root.bottomLeftRadius
        bottomRightRadius: root.bottomRightRadius
        color: root.color
    }

    contentItem: RowLayout {
        layoutDirection: root.placeIconRight ? Qt.RightToLeft : Qt.LeftToRight
        Item {
            Layout.fillWidth: false
            Layout.preferredHeight: 20 
            Layout.preferredWidth: 20

            Loader {
                id: iconLoader
                anchors.fill: parent

                readonly property Component image: IconImage {
                    source: root.imageIcon
                    anchors.fill: parent
                }
                readonly property Component text: Text {
                    text: root.textIcon
                    color: root.fgColor
                    anchors.fill: parent
                }
                sourceComponent: root.imageIcon === "" ? text : image
            }
        }
        Loader {
            Layout.fillWidth: true 
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            sourceComponent: root.mainContentComponent
        }
    }


    MouseArea {
        id: mouseArea 
        anchors.fill: parent 
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }

}