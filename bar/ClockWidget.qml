pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.color as Color

RowLayout {

    Rectangle {
        color: Qt.alpha(Color.Matugen.colors.surface_container, 1)
        implicitWidth: clock.implicitWidth + 10
        implicitHeight: clock.implicitHeight + 5
        radius: 6
        RowLayout {
            id: clock

            anchors.centerIn: parent
            spacing: 10
            Text {
                font.pixelSize: 12
                font.family: "JetBrains Mono"
                font.bold: true
                color: Color.Matugen.colors.on_surface
                text: ClockProcess.time
            }

            Text {
                font.pixelSize: 12
                font.family: "JetBrains Mono"
                color: Color.Matugen.colors.on_surface_variant
                text: ClockProcess.date
            }

        }
    }


}
