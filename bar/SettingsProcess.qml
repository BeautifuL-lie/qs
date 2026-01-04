import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    property alias toggleSwaync: toggleSwaync
    property alias closeSwaync: closeSwaync

    Process {
        id: toggleSwaync

        command: ["sh", "-c", "pkill -x rofi 2>/dev/null; swaync-client -t -sw"]
    }

    Process {
        id: closeSwaync

        command: ["sh", "-c", "swaync-client -cp 2>/dev/null"]
    }

}
