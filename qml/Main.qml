import QtQuick
import QtQuick.Controls

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "SCXML Qt6 Example"

    property string statusText: ""

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "Value: " + myModel.value
            font.pointSize: 20
        }

        Row {
            spacing: 10
            Button {
                text: "Start"
                onClicked: statemachine.sendStart()
            }
            Button {
                text: "Stop"
                onClicked: statemachine.sendStop()
            }
        }

        Button {
            text: "Update Value"
            onClicked: statemachine.sendUpdate(Math.floor(Math.random()*100))
        }
    }

    // Status bar at the bottom
    Rectangle {
        color: "#e0e0e0"
        height: 28
        width: parent.width
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        Text {
            anchors.centerIn: parent
            text: statusText
        }
    }

    // Listen for the 'activated' event from the SCXML statemachine
    Connections {
        target: statemachine
        function onActivated() {
            statusText = "Activated event received at " + Qt.formatTime(new Date(), "hh:mm:ss")
        }
    }
}
