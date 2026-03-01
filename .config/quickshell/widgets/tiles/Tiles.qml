import Quickshell
import QtQuick 
import QtQuick.Layouts

Rectangle {
    id: root 

    color: "transparent"

    implicitHeight: grid.implicitHeight
    implicitWidth: grid.implicitWidth

    GridLayout {
        id: grid
        columns: 1
        WeatherTile {}
    }
}