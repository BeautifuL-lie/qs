// ClockWidget.qml
import QtQuick
import QtQuick.Layouts
import qs.color as Color

RowLayout {
    spacing: 13

    Text {
        font.pixelSize: 14
        font.bold: true
        font.family: "Iosevka NF"
        color: Color.Matugen.colors.primary
        // ambil data dari singleton
        text: ClockProcess.time
    }

    Text {
        font.pixelSize: 14
        font.bold: true
        font.family: "Iosevka NF"
        color: Color.Matugen.colors.tertiary
        // ambil data dari singleton
        text: ClockProcess.date
    }

}
