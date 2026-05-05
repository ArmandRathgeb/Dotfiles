import Quickshell 
import Quickshell.Io
import QtQuick 
import qs.services
import qs.widgets.common

Item {
    id: root
    height: parent.height
    implicitWidth: button.implicitWidth

    signal clicked()

    IconButton {
        id: button
        anchors.centerIn: parent
        icon: Quickshell.iconPath(function() {
            if (Updates.numUpdates == 0) {
                return "update-none"
            } else if (Updates.numUpdates < 40) {
                return "update-low"
            } else if (Updates.numUpdates < 60) {
                return "update-medium"
            }
            return "update-high" 
        }());
        implicitHeight: 20
        implicitWidth: 20
        onClicked: root.clicked()
        StyledTooltip {
            visible: button.hovered
            text: "%1 updates".arg(Updates.numUpdates)
            x: parent.width
            height: 30
        }
    }
}