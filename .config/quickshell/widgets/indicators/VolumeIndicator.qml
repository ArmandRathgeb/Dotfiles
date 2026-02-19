import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services
import qs

Rectangle {
    id: root
    implicitHeight: rowLayout.implicitHeight
    implicitWidth: rowLayout.implicitWidth

    color: "transparent"

    RowLayout {
        id: rowLayout
        Text {
            id: sound
            color: Volume.isSoundMuted ? Config.theme.accentRed : Config.theme.fgPrimary
            text: {
                if (Volume.isSoundMuted) 
                    return "󰝟"
                if (Volume.soundVolume <= .3)
                    return ""
                if (Volume.soundVolume <= .6)
                    return ""
                return ""
                
            }
        }
        Text {
            id: mic
            text: (Volume.isMicMuted) ? "󰍭" : "󰍬"
            color: Volume.isMicMuted ? Config.theme.accentRed : Config.theme.accentGreen 
        }
    }
}