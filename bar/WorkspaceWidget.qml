import QtQuick
import Quickshell
import qs.color as Color

Row {
    //anchors.verticalCenter: parent.verticalCenter

    function isWorkspaceEmpty(workspaceId: int) : bool {
        for (let i = 0; i < NiriService.instance.windows.count; i++) {
            let item = NiriService.instance.windows.data(NiriService.instance.windows.index(i, 0), Qt.UserRole + 5);
            if (item === workspaceId)
                return false;

        }
        return true;
    }

    function updateWorkspaceVisuals(rect: Rectangle, model: QtObject) {
        rect.color = rect.updateColors();
        rect.border.color = rect.updateBorderColor();
        if (rect.workspaceText)
            rect.workspaceText.color = rect.updateTextColor();

    }

    spacing: 2

    Repeater {
        model: NiriService.instance.workspaces

        delegate: Rectangle {
            id: rect

            property Text workspaceText: textItem

            function updateColors() {
                if (model.isFocused && !isWorkspaceEmpty(model.id)) {
                    rect.gradient = grad;
                    return "transparent";
                }
                rect.gradient = null;
                return isWorkspaceEmpty(model.id) ? Color.Matugen.colors.surface_container : Color.Matugen.colors.outline_variant;
            }

            function updateBorderColor() {
                return model.isFocused ? Color.Matugen.colors.primary : isWorkspaceEmpty(model.id) ? Color.Matugen.colors.outline_variant : Color.Matugen.colors.surface_variant;
            }

            function updateTextColor() {
                return isWorkspaceEmpty(model.id) ? Color.Matugen.colors.outline : Color.Matugen.colors.on_surface;
            }

            color: updateColors()
            border.color: updateBorderColor()
            border.width: 2
            height: 20
            radius: 8
            width: model.isFocused ? 52 : 24

            Text {
                id: textItem

                anchors.centerIn: parent
                text: model.index
                color: rect.updateTextColor()
                font.weight: 500
                font.pixelSize: 12
                font.family: "JetBrains Mono"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: NiriService.instance.focusWorkspaceById(model.id)
                cursorShape: Qt.PointingHandCursor
            }

            Connections {
                function onDataChanged() {
                    updateWorkspaceVisuals(rect, model);
                }

                function onRowsInserted() {
                    updateWorkspaceVisuals(rect, model);
                }

                function onRowsRemoved() {
                    updateWorkspaceVisuals(rect, model);
                }

                function onModelReset() {
                    updateWorkspaceVisuals(rect, model);
                }

                target: NiriService.instance.windows
            }

            Connections {
                function onIsFocusedChanged() {
                    rect.color = rect.updateColors();
                    rect.border.color = rect.updateBorderColor();
                }

                target: model
            }

            gradient: Gradient {
                id: grad

                orientation: Gradient.Vertical

                GradientStop {
                    position: 0
                    color: Color.Matugen.colors.surface_variant
                }

                GradientStop {
                    position: 1
                    color: Color.Matugen.colors.primary_container
                }

            }

            Behavior on width {
                NumberAnimation {
                    duration: 400
                    easing.type: Easing.OutQuint
                }

            }

        }

    }

}
