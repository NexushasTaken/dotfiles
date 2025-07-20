pragma Singleton

import Quickshell
import Quickshell.I3
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Singleton {
  id: root
  property var event
  property string name
  property string class_
  property int count: 1

  readonly property var monitors: I3.monitors
  readonly property var workspaces: I3.workspaces

  Process {
    running: true
    command: [ "i3-msg", "-t", "subscribe", "-m", '[ "window" ]' ]
    stdout: SplitParser {
      onRead: data => {
        let event = JSON.parse(data)
        //console.log(data)
        root.event = event
        switch (event?.container?.type) {
          case "con":
          case "floating_con":
            // TODO: Icon Instead?
            root.name = event?.container?.name ?? root.name
            root.class_ = event?.container?.window_properties?.class ?? root.class_
            break;
          case "workspace":
            break;
          default:
            break;
        }
      }
    }
  }

  // TODO: Use this again! FKKK
  Connections {
    target: I3
    function onRawEvent(event) {
      //console.log("count: ", root.count)
      //console.log("type:", event.type)
      //console.log("data:", event.data)
      //console.log()
      if (["get_outputs"].includes(event.type)) {
        //I3.refreshMonitors()
      } else if (["get_workspaces"].includes(event.type)) {
        //I3.refreshWorkspaces()
      }
      root.count += 1
    }
    function onConnected() {
      //console.log("Connected")
    }
    function onFocusedWorkspaceChanged() {
      //console.log("Focused Workspace Changed")
    }
  }
}
