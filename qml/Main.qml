import QtQuick
import QtQuick.Controls

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "SCXML Qt6 Example"

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
}
