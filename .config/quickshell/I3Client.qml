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

  Process {
    running: true
    command: [ "i3-msg", "-t", "subscribe", "-m", '[ "window", "workspace" ]' ]
    stdout: SplitParser {
      onRead: data => {
        let event = JSON.parse(data)
        console.log(data)
        root.event = event
        switch (event?.container?.type) {
          case "con":
          case "floating_con":
            // TODO: Icon Instead?
            root.name = event?.container?.name
            root.class_ = event?.container?.window_properties?.class
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
      console.log("count: ", root.count)
      console.log(event)
      root.count += 1
    }
  }
}
