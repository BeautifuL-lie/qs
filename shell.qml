import QtQuick
import Quickshell
import qs.bar
import qs.services

ShellRoot {
    Bar {
        Component.onCompleted: console.log("Bar Loaded")
    }

    State{}

    Connections {
        function onReloadCompleted() {
            Quickshell.inhibitReloadPopup();
        }

        target: Quickshell
    }

}
