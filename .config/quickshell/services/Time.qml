pragma Singleton 

import Quickshell
import QtQuick

Singleton {
    id: root 
    readonly property string timeAndDate: {
        Qt.formatDateTime(clock.date, "hh:mm MMM d, yyyy")
    }
    readonly property string time: {
        Qt.formatDateTime(clock.date, "hh:mm")
    }
    readonly property string date: {
        Qt.formatDateTime(clock.date, "MMM d, yyyy")
    }

    SystemClock {
        id: clock 
        precision: SystemClock.Minutes
    }
}