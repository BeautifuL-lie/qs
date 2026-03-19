// ClockWidget.qml
import QtQuick
import QtQuick.Layouts
import qs.color as Color

RowLayout {
    spacing: 10

    Text {
        font.pixelSize: 12
        font.family: "JetBrains Mono"
        color: Color.Matugen.colors.primary
        // ambil data dari singleton
        text: ClockProcess.time
    }

    Text {
        font.pixelSize: 12
        font.family: "JetBrains Mono"
        color: Color.Matugen.colors.tertiary
        // ambil data dari singleton
        text: ClockProcess.date
    }

}
