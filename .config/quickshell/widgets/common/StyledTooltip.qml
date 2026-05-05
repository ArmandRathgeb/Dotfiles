import QtQuick
import QtQuick.Controls 
import qs 

ToolTip {
    id: root 

    font {
        family: Config.theme.fontFamily
        pixelSize: 11
    }
    palette.toolTipText: Config.theme.fgPrimary

    background: Rectangle {
        color: Config.theme.bgBase
        border.color: Config.theme.accentMagenta
    }
}