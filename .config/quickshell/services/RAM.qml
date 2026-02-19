pragma Singleton

import Quickshell 
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property string ramUsedKb
    property string ramPercent
    property string ramLeftKb

    Process {
        id: ramProc 
        command: ["sh", "-c", "free | awk 'NR==2 {printf \"%.0f %.1f %.1f\", ($3/$2)*100, $3, $2}'"]
        running: true 
        stdout: SplitParser {
            onRead: data => {
                const [rp, ru, rl] = data.split(" ")
                root.ramUsedKb  = ru 
                root.ramPercent = rp 
                root.ramLeftKb  = rl
            }
        }
    }

    Timer {
        interval: 10000
        running: true 
        repeat: true 
        onTriggered: ramProc.running = true
    }
}