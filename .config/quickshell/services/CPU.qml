pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root 

    property string cpuLoadPercent

    Process {
        id: cpuProc
        running: true
        command: ["sh", "-c", "top -bn2 -d 0.5 | grep '^%Cpu' | tail -1 | awk '{printf \"%.1f\", (100-$8)}'"]
        stdout: StdioCollector {
            onStreamFinished: root.cpuLoadPercent = this.text
        }
    }

    Timer {
        interval: 1000
        running: true 
        repeat: true 
        onTriggered: cpuProc.running = true
    }
}
