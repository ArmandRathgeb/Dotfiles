import Quickshell 
import QtQuick 
import QtQuick.Effects
import qs

Rectangle {
    id: root
    clip: true
    radius: 20

    color: Qt.rgba(
        Config.theme.bgBase.r,
        Config.theme.bgBase.g,
        Config.theme.bgBase.b,
        0.75
    )

    implicitHeight: 200
    implicitWidth: 200

    // Frosted glass effects 
    MultiEffect {
        id: frost
        source: root
        anchors.fill: parent
        blurEnabled: true
        blurMax: 16
        blur: .75
        colorizationColor: "#40FFFFFF"
        colorization: .5
        
    }
}