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
        icon: {
            if (Updates.numUpdates == 0) {
                return "image://icon/update-none"
            } else if (Updates.numUpdates < 40) {
                return "image://icon/update-low"
            } else if (Updates.numUpdates < 60) {
                return "image://icon/update-medium"
            }
            return "image://icon/update-high" 
        }
        implicitHeight: 20
        implicitWidth: 20
        onClicked: root.clicked()
    }
}