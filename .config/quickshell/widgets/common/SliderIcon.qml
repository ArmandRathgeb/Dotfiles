import Quickshell
import Quickshell.Widgets 
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: root 
    property string icon
    property string textIcon
    property bool clickableIcon: false

    property int sliderWidth: parent.width
    property int iconWidth: 20

    property alias from: slider.from 
    property alias value: slider.value 
    property alias to: slider.to
    property alias background: slider.background
    property alias handle: slider.handle
    property alias visualPosition: slider.visualPosition
    property alias availableWidth: slider.availableWidth

    signal clicked()
    signal moved()

    implicitHeight: row.implicitHeight
    implicitWidth: row.implicitWidth


    Row {
        id: row
        spacing: 5
        MouseArea {
            id: mouseArea
            implicitHeight: root.iconWidth
            implicitWidth: root.iconWidth
            Layout.fillHeight: true
            onClicked: root.clicked()
            enabled: root.clickableIcon
            cursorShape: root.clickableIcon ? Qt.PointingHandCursor : Qt.ArrowCursor
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Loader {
                id: loader
                anchors.fill: parent
                readonly property Component image: IconImage {
                    source: root.icon
                    anchors.fill: parent

                }
                readonly property Component text: Text {
                    text: root.textIcon
                    anchors.fill: parent
                }
                sourceComponent: root.icon === "" ? text : image
            }
        }
        
        Slider {
            id: slider
            implicitHeight: Math.max(root.iconWidth, this.background.implicitHeight)
            width: root.sliderWidth - root.iconWidth - 5
            onMoved: root.moved()
        }
    }
}