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
        columns: 2
        RssTile {
            Layout.columnSpan: 2
            Layout.rowSpan: 2
        }
        WeatherTile {}
        ClockTile {}
    }
}