pragma Singleton 
pragma ComponentBehavior: Bound

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

    readonly property string timeWithSec: {
        Qt.formatDateTime(clock.date, "hh:mm:ss")
    }

    readonly property alias hours  : clock.hours
    readonly property alias minutes: clock.minutes
    readonly property alias seconds: clock.seconds 

    SystemClock {
        id: clock 
        precision: SystemClock.Seconds
    }
}