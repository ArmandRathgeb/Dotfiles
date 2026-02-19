//@ pragma UseQApplication
import Quickshell
import Quickshell.Hyprland
import QtQuick

ShellRoot {
    id: shellRoot 

    property bool showCalendar: false 
    property bool showControlCenter: false
    property bool showUpdateCenter: false

    // Calendar
    PanelWindow {
        id: calendarWindow
        anchors {
            top: true 
        }
        implicitWidth: calendar.implicitWidth
        implicitHeight: calendar.implicitHeight

        exclusiveZone: 0
        color: "transparent"
        visible: shellRoot.showCalendar

        HyprlandFocusGrab {
            id: calendarGrab 
            active: shellRoot.showCalendar
            windows: [calendarWindow]
            onCleared: shellRoot.showCalendar = false
        }

        CalendarWidget {
            id: calendar
        }
    }

    // Control center
    LazyLoader {
        loading: true
        PanelWindow {
            id: controlCenterWindow
            anchors {
                top: true 
                right: true
            }
            implicitHeight: controlCenter.implicitHeight
            implicitWidth: controlCenter.implicitWidth
            margins.right: 20
            margins.top: 30

            exclusiveZone: 0
            color: "transparent"
            visible: shellRoot.showControlCenter

            HyprlandFocusGrab {
                id: controlGrab
                active: shellRoot.showControlCenter
                windows: [controlCenterWindow]
                onCleared: shellRoot.showControlCenter = false
            }

            ControlCenter {
                id: controlCenter 
            }
        }
    }

    LazyLoader {
        loading: true
        PanelWindow {
            id: updateWindow
            anchors {
                top: true 
                right: true
            }
            margins {
                top: 8
                right: 250
            }
            implicitHeight: 200
            implicitWidth: 200
            exclusiveZone: 0
            color: "transparent"
            visible: shellRoot.showUpdateCenter

            HyprlandFocusGrab {
                id: updateGrab
                active: shellRoot.showUpdateCenter
                windows: [updateWindow]
                onCleared: shellRoot.showUpdateCenter = false
            }
            UpdatesWidget {
                id: updatesWidget
                anchors.centerIn: parent
            }
        }
    }

    Variants {
        model: Quickshell.screens 

        PanelWindow {
            property var modelData 
            screen: modelData 
            anchors {
                top: true 
                left: true 
                right: true
            }
            margins.top: 2
            implicitHeight: 30
            color: "transparent"

            Bar {
                id: bar
                anchors.fill: parent
                onToggleCalendar: {
                    shellRoot.showCalendar = !shellRoot.showCalendar
                }
                onToggleControlCenter: {
                    shellRoot.showControlCenter = !shellRoot.showControlCenter
                }
                onToggleUpdateCenter: {
                    shellRoot.showUpdateCenter = !shellRoot.showUpdateCenter
                }

            }
        }
    }
}
