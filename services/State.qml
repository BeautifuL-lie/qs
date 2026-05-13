import QtQuick
import Quickshell
import Quickshell.Io
import qs.bar

IpcHandler {
    target: "popup"
    
    function close(): void {
        BatteryProcess.closePopup();
    }

}
