pragma Singleton 

import Quickshell
import Quickshell.Io 

Singleton {
    id: root 

    property bool dndEnabled: false

    function toggleDND() {
        Quickshell.execDetached(["dunstctl", "set-paused", "toggle"])
        checkDnd.running = true
    }

    Process {
        id: checkDnd
        command: [ "dunstctl", "is-paused"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.dndEnabled = this.text.trim() === 'true'
            } 
        }
        running: true
    }
}