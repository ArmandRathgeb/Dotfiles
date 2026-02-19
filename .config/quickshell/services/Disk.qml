pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io 

Singleton {
    id: root 
    property string totalSize 
    property string totalUsed 
    property string diskAvail 
    property string percentUsed 

    Process {
        id: diskProc
        running: true
        command: ["sh", "-c", "df -h / | awk 'NR==2 {gsub(\"G\",\"\",$3); gsub(\"G\",\"\",$4); gsub(\"G\",\"\",$2); gsub(\"%\",\"\",$5); print $5\" \"$3\" \"$4\" \"$2\" \"$1}'"]
        stdout: SplitParser{
            onRead: (data) => {
                const [pu, tu, da, ts] = data.split(" ")
                root.percentUsed = pu 
                root.totalUsed   = tu 
                root.diskAvail   = da 
                root.totalSize   = ts
            }
        }
    }

    Timer {
        interval: 1000000
        running: true 
        repeat: true 
        onTriggered: diskProc.running = true
    }
}