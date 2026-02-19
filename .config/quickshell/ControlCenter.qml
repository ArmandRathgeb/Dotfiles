import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Services.UPower
import Quickshell.Widgets
import qs
import qs.services
import qs.widgets.indicators
import qs.widgets.common
import qs.widgets

Rectangle {
    id: root
    color: Config.theme.bgBase
    anchors.fill: parent
    implicitHeight: layout.implicitHeight + 20
    implicitWidth: layout.implicitWidth + 20
    radius: 20


    ColumnLayout {
        id: layout
        anchors {
            centerIn: parent 
            margins: 10 
            fill: parent
        }
        spacing: 20
        ControlCenterClock {
            Layout.fillWidth: true 
            Layout.fillHeight: true
        }
        RowLayout {
            Media {
                id: mediaPlayer
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: 350
            }
            PowerButtons {
                Layout.fillHeight: true 
                Layout.fillWidth: true
            }
        }

        BrightnessSlider {
            id: brightnessSlider
            Layout.fillWidth: true
        }
        VolumeSlider {
            id: volumeSlider
            Layout.fillWidth: true
        }

        GridLayout {
            id: grid
            columns: 2
            rowSpacing: 10
            columnSpacing: 10
            Layout.fillWidth: true 
            Layout.fillHeight: true

            RoundedButton {
                Layout.fillWidth: true
                Layout.fillHeight: true
                textIcon: Idle.inhibit ? "󰈈 " : "󰈉 "
                text: "Idle Inhibitor"
                color: Idle.inhibit ? Config.theme.surface0 : Config.theme.surface1
                onClicked: {
                    Idle.toggleInhibit()
                    console.log("Idle inhibitor state:", Idle.inhibit ? "on" : "off")
                }
            }
            RoundedButton {
                Layout.fillWidth: true
                Layout.fillHeight: true
                fgColor: PowerProfiles.profile !== PowerProfiles.Performance ? Config.theme.accentBlack : Config.theme.fgPrimary
                textIcon: {
                    switch(PowerProfiles.profile) {
                    case PowerProfiles.Balanced:    return "󰾅 "
                    case PowerProfiles.Performance: return "󰓅 "
                    case PowerProfiles.PowerSaver:  return "󰾆 "
                    }
                }
                text: {
                    switch(PowerProfiles.profile) {
                    case PowerProfiles.Balanced:    return "Balanced"
                    case PowerProfiles.Performance: return "Performance"
                    case PowerProfiles.PowerSaver:  return "Power saver"
                    }
                }
                color: {
                    switch(PowerProfiles.profile) {
                    case PowerProfile.Balanced:    return Config.theme.accentGreen
                    case PowerProfile.Performance: return Config.theme.accentRed
                    case PowerProfile.PowerSaver:  return Config.theme.accentYellow
                    }
                }
                onClicked: PowerProfiles.profile = (PowerProfiles.profile + 1) % 3
            }
            RoundedButton {
                Layout.fillWidth: true
                Layout.fillHeight: true
                property bool airplaneOn: false 
                Process {
                    id: runAirplane
                }
                imageIcon: airplaneOn ? "image://icon/airplane-mode-symbolic" : "image://icon/airplane-mode-disabled-symbolic"
                text: "Airplane mode"
                color: airplaneOn ? Config.theme.surface0 : Config.theme.surface1
                onClicked: {
                    if (airplaneOn) {
                        runAirplane.exec(["nmcli", "radio", "all", "on"])
                    } else {
                        runAirplane.exec(["nmcli", "radio", "all", "off"])
                    }
                    airplaneOn = !airplaneOn
                }
            }
        }
    }
}