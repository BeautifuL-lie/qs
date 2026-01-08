import QtQuick
import Quickshell
import qs.bar

ShellRoot {
    Bar {
        Component.onCompleted: console.log("Bar Loaded")
    }

    Connections {
        function onReloadCompleted() {
            Quickshell.inhibitReloadPopup();
        }

        target: Quickshell
    }

}
