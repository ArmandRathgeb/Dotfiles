pragma Singleton 

import Quickshell
import Quickshell.Io 

Singleton {
    id: root 

    property bool dndEnabled: false

    function toggleDND() {
        dnd.running = true
        checkDnd.running = true
    }

    Process {
        id: dnd
        command: [ "dunstctl", "set-paused", "toggle"]
        running: false
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