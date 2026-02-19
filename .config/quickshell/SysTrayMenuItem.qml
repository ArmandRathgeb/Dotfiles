pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.widgets.common

RoundedButton {
    id: root
    required property QsMenuEntry menuEntry
    property bool forceIconColumn: false
    property bool forceSpecialInteractionColumn: false
    readonly property bool hasIcon: menuEntry.icon.length > 0
    readonly property bool hasSpecialInteraction: menuEntry.buttonType !== QsMenuButtonType.None

    signal dismiss()
    signal openSubmenu(handle: QsMenuHandle)

    enabled: !menuEntry.isSeparator
    opacity: 1

    //border.width: 1

    horizontalPadding: 12
    implicitWidth: contentItem.implicitWidth + horizontalPadding * 2
    implicitHeight: menuEntry.isSeparator ? 1 : 36
    Layout.topMargin: menuEntry.isSeparator ? 4 : 0
    Layout.bottomMargin: menuEntry.isSeparator ? 4 : 0
    Layout.fillWidth: true

    Component.onCompleted: {
        if (menuEntry.isSeparator) {
            root.background.color = Config.theme.bgSecondary
        }
    }

    onClicked: {
        if (menuEntry.hasChildren) {
            root.openSubmenu(root.menuEntry)
            return 
        }
        menuEntry.triggered()
        root.dismiss()
    }


    contentItem: RowLayout {
        id: contentItem
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            leftMargin: root.horizontalPadding
            rightMargin: root.horizontalPadding
        }
        spacing: 8
        visible: !root.menuEntry.isSeparator

        // Interaction: checkbox or radio button
        Item {
            visible: root.hasSpecialInteraction || root.forceSpecialInteractionColumn
            implicitWidth: 20
            implicitHeight: 20

            Loader {
                anchors.fill: parent
                active: root.menuEntry.buttonType === QsMenuButtonType.RadioButton

                sourceComponent: RadioButton {
                    enabled: false
                    padding: 0
                    checked: root.menuEntry.checkState === Qt.Checked
                }
            }

            Loader {
                anchors.fill: parent
                active: root.menuEntry.buttonType === QsMenuButtonType.CheckBox && root.menuEntry.checkState !== Qt.Unchecked

                sourceComponent: CheckBox {
                    text: root.menuEntry.checkState === Qt.PartiallyChecked ? "check_indeterminate_small" : "check"
                    checkState: root.menuEntry.checkState
                }
            }
        }

        // Button icon
        Item {
            visible: root.hasIcon || root.forceIconColumn
            implicitWidth: 20
            implicitHeight: 20

            Loader {
                anchors.centerIn: parent
                active: root.menuEntry.icon.length > 0
                sourceComponent: IconImage {
                    asynchronous: true
                    source: root.menuEntry.icon
                    implicitSize: 20
                    mipmap: true
                }
            }
        }

        Text {
            id: label
            text: root.menuEntry.text
            font.pixelSize: Config.theme.fontSize
            font.family: Config.theme.fontFamily
            color: Config.theme.fgPrimary
            Layout.fillWidth: true
        }

        Loader {
            active: root.menuEntry.hasChildren

            sourceComponent: IconImage {
                source: "image://icon/handle-right"
                implicitWidth: 20
                implicitHeight: 20
            }
        }
    }
}