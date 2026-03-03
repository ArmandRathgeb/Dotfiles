import Quickshell
import Quickshell.Widgets
import QtQuick 
import QtQuick.Controls
import QtQuick.Layouts
import qs
import qs.services

Tile {
    id: root

    property int currentWeather: 0
    visible: Weather.weatherInformation.length > 0

    ColumnLayout {
        id: weatherLayout
        anchors {
            centerIn: parent 
            margins: 10 
            fill: parent
        }
        IconImage {
            source: Weather.weatherInformation[root.currentWeather]?.icon
            Layout.fillWidth: true 
            Layout.fillHeight: true
        }
        Text {
            text: Weather.weatherInformation[root.currentWeather]?.temp 
            font.family: Config.theme.fontFamily
            color: Config.theme.fgPrimary
            horizontalAlignment: Text.AlignVCenter
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }
        Text {
            text: Weather.weatherInformation[root.currentWeather]?.city 
            font.family: Config.theme.fontFamily
            color: Config.theme.fgPrimary
            horizontalAlignment: Text.AlignVCenter
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }
    }

    Timer {
        interval: 30000
        repeat: true
        running: true
        onTriggered: {
            currentWeather = (currentWeather + 1) % Weather.weatherInformation.length
            root.visible = false 
            root.visible = true
        }
    }
}