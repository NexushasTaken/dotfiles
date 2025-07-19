import Quickshell
import Quickshell.I3
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ShellRoot {
  Scope {
    id: root

    Variants {
      model: Quickshell.screens

      PanelWindow {
        property var modelData
        screen: modelData

        color: "transparent"
        implicitHeight: 30

        anchors {
          top: true
          left: true
          right: true
        }

        Rectangle {
          id: bar
          color: "#1a1b26"
          anchors.fill: parent

          Row {
            anchors.verticalCenter: bar.verticalCenter
            spacing: 10
            padding: 10

            Button {
              id: control
              flat: true
              padding: 0
              contentItem: Text {
                text: ""
                color: control.down ? "#7aa2f7" : "#7dcfff"
                font.family: "Hack Nerd Font"
                font.pointSize: 16
              }
              background: Rectangle {
                implicitHeight: 12
                implicitWidth: 12
                opacity: 0
              }
            }

            Row {
              id: workspaces
              spacing: 4
              anchors.verticalCenter: parent.verticalCenter

              Repeater {
                model: I3.workspaces

                Rectangle {
                  id: entry
                  required property var modelData
                  radius: (width + height) / 2
                  color: modelData.focused ? "#495275" : "transparent"

                  Text {
                    id: number
                    anchors.verticalCenter: entry.verticalCenter
                    text: entry.modelData.number
                    color: "#c0caf5"
                    leftPadding: 10
                    rightPadding: 8
                  }

                  Row {
                    id: clients
                    anchors.left: number.right
                    anchors.verticalCenter: entry.verticalCenter
                    spacing: 8
                    rightPadding: 10

                    Repeater {
                      model: 1
                      RowLayout {
                        id: client
                        IconImage {
                          implicitSize: 14
                          source: Icons.getAppIcon(I3Client.class_, "image-missing")
                        }

                        Text {
                          color: "#c0caf5"
                          text: {
                            let visible = entry.modelData.focused
                            client.visible = visible
                            if (visible) {
                              let name = I3Client.name ?? ""
                              return `${name}`
                            }
                            return ""
                          }
                        }
                      }
                    }
                  }
                  implicitWidth: number.width + clients.width // adjust as needed
                  implicitHeight: 20
                }
              }
            }
          }
          Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            spacing: 10
            padding: 10

            Text {
              color: "#c0caf5"
            }
          }
        }
      }
    }
  }
}
