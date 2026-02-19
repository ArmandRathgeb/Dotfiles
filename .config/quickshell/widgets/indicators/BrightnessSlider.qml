import QtQuick
import qs
import qs.services
import qs.widgets.common

SliderIcon {
    id: root
    icon: "image://icon/display-brightness"
    iconWidth: 30
    to: 100
    from: 0
    value: Brightness.brightnessPercent
    onValueChanged: Brightness.setBrightness(value)
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