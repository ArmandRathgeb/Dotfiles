import QtQuick
import qs
import qs.services
import qs.widgets.common 

SliderIcon {
    id: root 
    icon: {
        if (Volume.isSoundMuted) 
            return "image://icon/audio-volume-muted"
        if (Volume.soundVolume <= .3)
            return "image://icon/audio-volume-low"
        if (Volume.soundVolume <= .6)
            return "image://icon/audio-volume-medium"
        return "image://icon/audio-volume-high"
    }
    clickableIcon: true
    iconWidth: 30
    onClicked: Volume.toggleSoundMute()
    to: 100
    from: 0
    value: Volume.soundVolume * 100
    onMoved: Volume.setVolume(value / 100.0)
    handle: Rectangle {}
    background: Rectangle {
        radius: 16
        implicitHeight: 30
        color: Config.theme.surface1
        width: root.availableWidth
        height: 30
        Rectangle {
            width: root.visualPosition * parent.width
            height: parent.height
            color: Config.theme.accentBlue
            radius: parent.radius
        }
    }
}