import QtQuick
import QtQuick.Layouts
import qs.color as Color

RowLayout {
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
