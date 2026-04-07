import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.color as Color

Item {
    id: battery

    property string percentage: Math.round(BatteryProcess.percentage * 100)
    property bool showPopup: false

    implicitHeight: batOutline.height
    implicitWidth: batOutline.width
    Layout.rightMargin: 2

    RowLayout {
        Rectangle {
            // Percentage text
            //Text {
            //  text: BatteryProcess.isCharging ? " " + percentage : percentage
            //color: Color.Matugen.colors.on_background
            //font.pixelSize: 9
            //font.bold: true
            //anchors.centerIn: parent
            //}

            id: batOutline

            width: 30
            height: 15
            color: "transparent"
            border.color: Color.Matugen.colors.on_background // outline
            border.width: 1.3
            radius: 3

            Rectangle {
                anchors.fill: parent
                color: Color.Matugen.colors.surface_container_highest
                anchors.margins: 1.2
                radius: 3

                // Battery fill
                Rectangle {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 1
                    width: Math.max(0, (parent.width - 2) * (percentage / 100))
                    color: {
                        if (BatteryProcess.isCharging)
                            return "#0fa866";

                        if (percentage <= 20)
                            return "#d00000";

                        if (percentage <= 30)
                            return "#ffb000";

                        return Color.Matugen.colors.outline_variant; //surface bright
                    }
                    radius: 2
                }

            }

            // Battery tip (the little nub on the right)
            Rectangle {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                width: 2
                height: 9
                color: batOutline.border.color
                radius: 1
            }

            Row {
                id: contentRow

                anchors.centerIn: parent
                spacing: 1

                Text {
                    id: chargeIcon

                    text: ""
                    visible: BatteryProcess.isCharging
                    color: Color.Matugen.colors.on_background
                    font.pixelSize: 9
                }

                Text {
                    text: percentage
                    color: Color.Matugen.colors.on_background
                    font.pixelSize: 9
                    font.bold: true
                }

            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    battery.showPopup = !battery.showPopup;
                    SettingsProcess.closeSwaync.running = true;
                }
            }

        }

    }

    LazyLoader {
        active: battery.showPopup

        PanelWindow {
            //mask: Region {
            //}

            anchors.top: true
            anchors.right: true
            margins.top: screen.height / 150
            margins.right: screen.width / 175
            exclusiveZone: 0
            implicitWidth: 225
            implicitHeight: 110
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                radius: 10
                color: Color.Matugen.colors.surface_container
                opacity: 0.97
                border.color: Color.Matugen.colors.outline_variant
                border.width: 1

                RowLayout {
                    anchors.fill: parent

                    Item {
                        width: 80
                        height: 80
                        Layout.leftMargin: 20

                        Canvas {
                            id: donut

                            property real value: percentage / 100
                            property real lineWidth: 8
                            property color ringColor: Color.Matugen.colors.primary

                            anchors.fill: parent
                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.clearRect(0, 0, width, height);
                                var cx = width / 2;
                                var cy = height / 2;
                                var r = (width / 2) - lineWidth;
                                // background ring
                                ctx.beginPath();
                                ctx.arc(cx, cy, r, 0, Math.PI * 2);
                                ctx.strokeStyle = Color.Matugen.colors.surface_variant;
                                ctx.lineWidth = lineWidth;
                                ctx.stroke();
                                // progress ring
                                ctx.beginPath();
                                ctx.arc(cx, cy, r, -Math.PI / 2, -Math.PI / 2 + (Math.PI * 2 * value));
                                ctx.strokeStyle = ringColor;
                                ctx.lineWidth = lineWidth;
                                ctx.stroke();
                            }
                            onValueChanged: requestPaint()
                        }

                        Text {
                            anchors.centerIn: parent
                            text: Math.round(percentage) + "%"
                            color: Color.Matugen.colors.on_background
                            font.pixelSize: 15
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                        }

                    }

                    ColumnLayout {
                        Layout.leftMargin: 12
                        spacing: 2

                        Text {
                            Layout.fillWidth: true
                            text: BatteryProcess.isPluggedIn ? "Plugged In" : "On Battery"
                            color: Color.Matugen.colors.on_background
                            font.pixelSize: 13
                            font.bold: true
                        }

                        Text {
                            Layout.fillWidth: true
                            visible: !BatteryProcess.isCharging && BatteryProcess.timeToEmpty > 0
                            text: {
                                let totalMinutes = Math.round(BatteryProcess.timeToEmpty / 60);
                                let h = Math.floor(totalMinutes / 60);
                                let m = totalMinutes % 60;
                                if (h > 0 && m > 0)
                                    return "Empty In: " + h + "h " + m + "m";

                                if (h > 0)
                                    return "Empty In: " + h + "h";

                                return "Empty In: " + m + "m";
                            }
                            color: Color.Matugen.colors.on_background
                            opacity: 0.7
                            font.pixelSize: 11
                        }

                        Text {
                            Layout.fillWidth: true
                            visible: BatteryProcess.isCharging && BatteryProcess.timeToFull > 0
                            text: {
                                let totalMinutes = Math.round(BatteryProcess.timeToFull / 60);
                                let h = Math.floor(totalMinutes / 60);
                                let m = totalMinutes % 60;
                                if (h > 0 && m > 0)
                                    return "Full in: " + h + "h " + m + "m";

                                if (h > 0)
                                    return "Full in: " + h + "h";

                                return "Full in: " + m + "m";
                            }
                            color: Color.Matugen.colors.on_background
                            opacity: 0.7
                            font.pixelSize: 11
                        }

                    }

                }

            }

        }

    }

}
