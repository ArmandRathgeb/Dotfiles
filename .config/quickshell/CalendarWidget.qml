import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    color: Config.theme.bgBase
    anchors.fill: parent
    implicitWidth: layout.implicitWidth + 40
    implicitHeight: layout.implicitHeight + 30
    radius: 20

    ColumnLayout {
        id: layout
        anchors.centerIn: parent
        DayOfWeekRow {
            locale: grid.locale 
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
        MonthGrid {
            delegate: Text {
                horizontalAlignment: Text.AlignHCenter 
                verticalAlignment: Text.AlignVCenter
                text: model.day
                font.family: Config.theme.fontFamily
                font.pixelSize: 14
                color: Config.theme.fgPrimary
                Rectangle {
                    anchors.fill: parent 
                    anchors.margins: -4
                    visible: box.containsMouse || model.date.toDateString() === new Date().toDateString()
                    border.color: box.containsMouse ? Config.theme.surface1 : Config.theme.surface0
                    color: "transparent"
                    radius: 4
                }
                MouseArea {
                    id: box
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    anchors.fill: parent
                    onClicked: {
                        var year  = model.year
                        var month = model.month + 1
                        var day   = model.day
                        var url   = "https://calendar.google.com/calendar/u/0/r/day/%1/%2/%3"
                        Qt.openUrlExternally(url.arg(year).arg(month).arg(day))
                    }
                }

            }
            id: grid 
            locale: Qt.locale()
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}