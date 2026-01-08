import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.color as Color

PanelWindow {
    id: bar

    property string opacity: "e6"

    implicitHeight: 32
    color: "#" + opacity + Color.Matugen.colors.background.slice(1)

    anchors {
        top: true
        left: true
        right: true
    }

    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 1
        color: Color.Matugen.colors.outline
        opacity: 0.8
    }

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        anchors.left: parent.left
        layoutDirection: Qt.LeftToRight

        WorkspaceWidget {
        }

    }

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        ClockWidget {
        }

    }

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 10
        anchors.right: parent.right
        layoutDirection: Qt.RightToLeft
        spacing: 10

        SettingsWidget {
        }

        BatteryWidget {
        }

        TrayWidget {
        }

    }

}
