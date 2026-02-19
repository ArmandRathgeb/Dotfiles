pragma Singleton 

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root 

    property real brightness 
    property real brightnessMax
    property real brightnessPercent: 100
    
    function getCurrentMonitor() {
        const foc = Hyprland.focusedMonitor.name
        return monitors.find(m => foc === m.screen.name)
    }

    Process {
        id: set 
    }

    Process {
        id: init 
        command: ["sh", "-c", `echo $(brightnessctl g) $(brightnessctl m)`]
        running: true

        stdout: SplitParser {
            onRead: data => {
                const [current, max] = data.split(" ")
                root.brightnessMax = parseInt(max)
                root.brightness = parseInt(current)
                root.brightnessPercent = root.brightness / root.brightnessMax * 100
            } 
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true 
        onTriggered: init.running = true
    }

    function setBrightness(brightness: int) {
        const b = Math.max(0, Math.min(brightness, 100))
        set.exec(["brightnessctl", "s", `${brightness}%` ])
    }

    function increaseBrightness() {
        set.exec(["brightnessctl", "s", "+5%"])
    }

    function decreaseBrightness() {
        set.exec(["brightnessctl", "s", "5%-"])
    }

}