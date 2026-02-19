import Quickshell
import QtQuick
import QtQuick.Layouts
import qs
import qs.services 

Rectangle {
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth
    color: "transparent"
    Column {
        id: layout
        anchors.fill: parent 
        Text {
            text: Time.time 
            color: Config.theme.fgPrimary
            font {
                family: Config.theme.fontFamily
                pixelSize: 32
            }
        }
        Text {
            text: Time.date
            color: Config.theme.fgPrimary
            font {
                family: Config.theme.fontFamily
                pixelSize: Config.theme.fontSize
            }
        }
    }
}
