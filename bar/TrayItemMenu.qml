// TrayItemMenu.qml
pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.color as Color

ListView {
  id: view 

  required property QsMenuOpener rootMenu
  required property QsMenuOpener trayMenu
  
  width: contentWidth
  height: contentHeight

  anchors.fill: parent 
  interactive: false
  spacing: 4

  model: ScriptModel {
    values: [...trayMenu?.children.values]
  }

  delegate: Rectangle {
    property var textColor: mouse.hovered ? Color.Matugen.colors.on_surface_variant : Color.Matugen.colors.on_surface
    property var rectColor: mouse.hovered ? Color.Matugen.colors.surface_container_high : Color.Matugen.colors.surface_container

    id: entry

    property var child: QsMenuOpener {
      menu: entry.modelData
    }

    required property QsMenuEntry modelData

    color: (modelData?.isSeparator) ? Color.Matugen.colors.surface_container_highest : rectColor
    height: (modelData?.isSeparator) ? 2 : 25
    anchors.horizontalCenter: parent.horizontalCenter
    width: (modelData?.isSeparator) ? 300 : 308
    radius: 0

    HoverHandler {
      id:mouse
    }

    TapHandler {
      onTapped: {

        if (entry.modelData.hasChildren) {
          view.trayMenu = entry.child;
          view.positionViewAtBeginning();
        } else {
          entry.modelData.triggered();
        }
      }
    }

    RowLayout {
      anchors.fill: parent 
      anchors.leftMargin: (entry.modelData?.buttonType == QsMenuButtonType.None) ? 10 : 2
      anchors.rightMargin: 10

      Item {
        Layout.fillHeight: true
        implicitWidth: this.height
        visible: entry.modelData?.buttonType == QsMenuButtonType.CheckBox

        Text {
          anchors.centerIn: parent
          color: entry.textColor
          text: (entry.modelData?.checkState != Qt.Checked) ? "" : ""
        }
      }

      Item {
      Layout.fillHeight: true
      Layout.fillWidth: true

        Text {
          id: text

          anchors.fill: parent
          color: entry.textColor
          text: entry.modelData?.text ?? ""
        
        }
      }

      Item {
        Layout.fillHeight: true
        implicitWidth: this.height
        visible: entry.modelData?.icon ?? false

        Image {
          anchors.fill: parent
          anchors.margins: 3
          fillMode: Image.PreserveAspectFit
          source: entry.modelData?.icon ?? ""
        }
      }

      Item {
        Layout.fillHeight: true
        implicitWidth: this.height
        visible: entry.modelData?.hasChildren ?? false

        Text {
          anchors.centerIn: parent
          color: entry.textColor
          text: ""
        }
      }
    }
  }
}
