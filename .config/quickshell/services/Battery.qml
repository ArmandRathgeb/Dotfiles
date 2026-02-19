pragma Singleton 

import Quickshell
import Quickshell.Services.UPower
import qs

Singleton {
    id: root 
    property bool available: UPower.displayDevice.isLaptopBattery
    property var chargeState: UPower.displayDevice.state 
    property bool isCharging: chargeState == UPowerDeviceState.Charging 
    property bool isPluggedIn: isCharging || chargeState == UPowerDeviceState.PendingCharge 
    property real percentage: UPower.displayDevice?.percentage ?? 1

    property bool isLow: available && (percentage <= Config.battery.low / 100)
    property bool isCritical: available && (percentage <= Config.battery.critical / 100)
    property bool isSuspending: available && (percentage <= Config.battery.suspend / 100)
    property bool isFull: available && (percentage >= Config.battery.full / 100)

    property bool isLowNotCharging: isLow && !isCharging
    property bool isCriticalNotCharging: isCritical && !isCharging
    property bool isSuspendingNotCharging: Config.battery.automaticSuspend && isSuspending && !isCharging

    onIsLowNotChargingChanged: {
        if (!root.available || !isLowNotCharging)
            return 
        Quickshell.execDetached([
            "notify-send", "Low battery", "-u", "critical", "--hint=int:transient:1"
        ])
    }

    onIsCriticalNotChargingChanged: {
        if(!root.available || !isCriticalNotCharging)
            return 
        Quickshell.execDetached([
            "notify-send", "Critically low battery", "-u", "critical", "--hint=int:transient:1"
        ])
    }

    onIsSuspendingNotChargingChanged: {
        if (root.available && isSuspendingNotCharging)
            Quickshell.execDetached([
                "bash", "-c", `systemctl suspend`
            ])
    }
}