pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQuick
import Quickshell.Io

Singleton {
    property bool available: UPower.displayDevice.isLaptopBattery
    property var chargeState: UPower.displayDevice.state
    property bool isCharging: chargeState == UPowerDeviceState.Charging
    property bool isPluggedIn: isCharging || chargeState == UPowerDeviceState.PendingCharge
    property real percentage: UPower.displayDevice?.percentage ?? 1
    //readonly property bool allowAutomaticSuspend: Config.data.battery.automaticSuspend

    property bool isLow: available && (percentage <= 30)
    property bool isCritical: available && (percentage <= 20)
   // property bool isSuspending: available && (percentage <= Config.data.battery.suspend / 100)

    property bool isLowAndNotCharging: isLow && !isCharging
    property bool isCriticalAndNotCharging: isCritical && !isCharging
   // property bool isSuspendingAndNotCharging: allowAutomaticSuspend && isSuspending && !isCharging

    property real energyRate: UPower.displayDevice.changeRate
    property real timeToEmpty: UPower.displayDevice.timeToEmpty
    property real timeToFull: UPower.displayDevice.timeToFull
    
    property bool isPopupVisible: false

    function togglePopup() {
        isPopupVisible = !isPopupVisible;
    }

    function closePopup() {
        isPopupVisible = false;
    }
}
