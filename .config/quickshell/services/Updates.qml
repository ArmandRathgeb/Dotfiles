pragma Singleton 

import Quickshell
import Quickshell.Io
import QtQuick
import qs

Singleton {
    id: root 

    property list<string> toUpdate
    property int numUpdates: toUpdate.length

    function update() {
        updateProc.exec(["sh" ,"-c", Config.terminal + " -e " + Config.updateCommand])
    }

    Process {
        id: updateProc
    }

    Process {
        id: checkUpdateProc
        command: ["sh", "-c", Config.updateCheck]
        stdout: SplitParser {
            onRead: data => { 
                const [app, oldVersion,_,newVersion] = data.split(" ")
                toUpdate.push(app)
            }
        }
        running: true
    }

    Timer {
        interval: Config.updateFrequencySeconds * 1000
        running: true 
        repeat: true 
        onTriggered: {
            toUpdate = []
            checkUpdateProc.running = true
        }
    }
}