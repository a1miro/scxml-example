import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 900
    height: 700
    title: "SCXML Parallel States Demo"

    property string connectionStatus: "Disconnected"
    property string processingStatus: "Idle"
    property string userStatus: "Waiting"
    property string systemStatus: "Monitoring"
    property color connectionColor: "#ff4444"
    property color processingColor: "#888888"
    property color userColor: "#888888"
    property color systemColor: "#44ff44"

    ScrollView {
        anchors.fill: parent
        anchors.margins: 10

        ColumnLayout {
            width: parent.width - 20
            spacing: 15

            // Header
            Text {
                text: "SCXML Parallel State Machine Demo"
                font.bold: true
                font.pointSize: 18
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "This demo shows concurrent state machines running in parallel:\nConnection Management, Data Processing, User Interface, and System Monitoring"
                font.pointSize: 12
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
            }

            // Status Dashboard
            GroupBox {
                title: "System Status Dashboard"
                Layout.fillWidth: true
                
                GridLayout {
                    columns: 2
                    anchors.fill: parent
                    rowSpacing: 10
                    columnSpacing: 20

                    // Connection Status
                    Rectangle {
                        color: connectionColor
                        radius: 5
                        Layout.fillWidth: true
                        height: 60
                        Text {
                            anchors.centerIn: parent
                            text: "Connection\n" + connectionStatus
                            color: "white"
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    // Processing Status
                    Rectangle {
                        color: processingColor
                        radius: 5
                        Layout.fillWidth: true
                        height: 60
                        Text {
                            anchors.centerIn: parent
                            text: "Data Processing\n" + processingStatus
                            color: "white"
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    // User Status
                    Rectangle {
                        color: userColor
                        radius: 5
                        Layout.fillWidth: true
                        height: 60
                        Text {
                            anchors.centerIn: parent
                            text: "User Interface\n" + userStatus
                            color: "white"
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    // System Status
                    Rectangle {
                        color: systemColor
                        radius: 5
                        Layout.fillWidth: true
                        height: 60
                        Text {
                            anchors.centerIn: parent
                            text: "System Monitor\n" + systemStatus
                            color: "white"
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
            }

            // Data Display
            GroupBox {
                title: "Data Model"
                Layout.fillWidth: true
                
                Text {
                    text: "Current Value: " + myModel.value
                    font.pointSize: 16
                    font.bold: true
                }
            }

            // Control Panels
            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                // Connection Controls
                GroupBox {
                    title: "Connection Management"
                    Layout.fillWidth: true
                    
                    ColumnLayout {
                        anchors.fill: parent
                        
                        Button {
                            text: "Connect"
                            Layout.fillWidth: true
                            onClicked: statemachine.connectToNetwork()
                        }
                        
                        Button {
                            text: "Disconnect"
                            Layout.fillWidth: true
                            onClicked: statemachine.disconnectFromNetwork()
                        }
                        
                        Button {
                            text: "Simulate Success"
                            Layout.fillWidth: true
                            onClicked: statemachine.simulateConnectionSuccess()
                        }
                        
                        Button {
                            text: "Simulate Failure"
                            Layout.fillWidth: true
                            onClicked: statemachine.simulateConnectionFailure()
                        }
                        
                        Button {
                            text: "Simulate Connection Lost"
                            Layout.fillWidth: true
                            onClicked: statemachine.simulateConnectionLost()
                        }
                        
                        Button {
                            text: "Retry Connection"
                            Layout.fillWidth: true
                            onClicked: statemachine.retryConnection()
                        }
                    }
                }

                // Processing Controls
                GroupBox {
                    title: "Data Processing"
                    Layout.fillWidth: true
                    
                    ColumnLayout {
                        anchors.fill: parent
                        
                        Button {
                            text: "Start Processing"
                            Layout.fillWidth: true
                            onClicked: statemachine.startProcessing()
                        }
                        
                        Button {
                            text: "Stop Processing"
                            Layout.fillWidth: true
                            onClicked: statemachine.stopProcessing()
                        }
                        
                        Button {
                            text: "Send Update"
                            Layout.fillWidth: true
                            onClicked: statemachine.sendUpdate(Math.floor(Math.random()*100))
                        }
                        
                        Button {
                            text: "Simulate Data Batch"
                            Layout.fillWidth: true
                            onClicked: statemachine.simulateDataBatch()
                        }
                        
                        Button {
                            text: "Simulate Error"
                            Layout.fillWidth: true
                            onClicked: statemachine.simulateProcessingError()
                        }
                        
                        Button {
                            text: "Complete Processing"
                            Layout.fillWidth: true
                            onClicked: statemachine.completeDataProcessing()
                        }
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                // User Interface Controls
                GroupBox {
                    title: "User Interaction"
                    Layout.fillWidth: true
                    
                    ColumnLayout {
                        anchors.fill: parent
                        
                        Button {
                            text: "User Interaction"
                            Layout.fillWidth: true
                            onClicked: statemachine.simulateUserInteraction()
                        }
                        
                        Button {
                            text: "User Login"
                            Layout.fillWidth: true
                            onClicked: statemachine.simulateUserLogin()
                        }
                        
                        Button {
                            text: "User Logout"
                            Layout.fillWidth: true
                            onClicked: statemachine.simulateUserLogout()
                        }
                        
                        Button {
                            text: "User Action"
                            Layout.fillWidth: true
                            onClicked: statemachine.simulateUserAction()
                        }
                        
                        Button {
                            text: "User Idle"
                            Layout.fillWidth: true
                            onClicked: statemachine.simulateUserIdle()
                        }
                        
                        Button {
                            text: "Session Timeout"
                            Layout.fillWidth: true
                            onClicked: statemachine.simulateSessionTimeout()
                        }
                    }
                }

                // System Monitoring Controls
                GroupBox {
                    title: "System Monitoring"
                    Layout.fillWidth: true
                    
                    ColumnLayout {
                        anchors.fill: parent
                        
                        Button {
                            text: "Report Healthy"
                            Layout.fillWidth: true
                            onClicked: statemachine.reportSystemHealthy()
                        }
                        
                        Button {
                            text: "Report Warning"
                            Layout.fillWidth: true
                            onClicked: statemachine.reportSystemWarning()
                        }
                        
                        Button {
                            text: "Report Critical"
                            Layout.fillWidth: true
                            onClicked: statemachine.reportSystemCritical()
                        }
                        
                        Button {
                            text: "Acknowledge Warning"
                            Layout.fillWidth: true
                            onClicked: statemachine.acknowledgeWarning()
                        }
                        
                        Button {
                            text: "System Recovery"
                            Layout.fillWidth: true
                            onClicked: statemachine.initiateSystemRecovery()
                        }
                        
                        Button {
                            text: "Shutdown System"
                            Layout.fillWidth: true
                            onClicked: statemachine.shutdownSystem()
                        }
                    }
                }
            }
        }
    }

    // Event Connections - Listen to all parallel state changes
    Connections {
        target: statemachine
        
        // Connection Events
        function onConnectionStatusChanged() {
            connectionStatus = "Status Changed"
            connectionColor = "#ffaa00"
        }
        
        function onConnectionAttempting() {
            connectionStatus = "Connecting..."
            connectionColor = "#ffaa00"
        }
        
        function onConnectionEstablished() {
            connectionStatus = "Connected"
            connectionColor = "#44ff44"
        }
        
        function onConnectionReconnecting() {
            connectionStatus = "Reconnecting..."
            connectionColor = "#ffaa00"
        }
        
        function onConnectionError() {
            connectionStatus = "Error"
            connectionColor = "#ff4444"
        }
        
        function onConnectionOffline() {
            connectionStatus = "Offline"
            connectionColor = "#888888"
        }
        
        // Processing Events
        function onProcessingIdle() {
            processingStatus = "Idle"
            processingColor = "#888888"
        }
        
        function onProcessingStarted() {
            processingStatus = "Active"
            processingColor = "#44ff44"
        }
        
        function onDataProcessed() {
            processingStatus = "Processing Data"
            processingColor = "#00aaff"
        }
        
        function onProcessingCompleting() {
            processingStatus = "Completing"
            processingColor = "#ffaa00"
        }
        
        function onProcessingError() {
            processingStatus = "Error"
            processingColor = "#ff4444"
        }
        
        // User Interface Events
        function onUiWaiting() {
            userStatus = "Waiting"
            userColor = "#888888"
        }
        
        function onUiActive() {
            userStatus = "Active"
            userColor = "#44ff44"
        }
        
        function onUiAuthenticated() {
            userStatus = "Authenticated"
            userColor = "#00ff88"
        }
        
        function onUserActionProcessed() {
            userStatus = "Action Processed"
            userColor = "#00aaff"
        }
        
        // System Monitor Events
        function onMonitorStarted() {
            systemStatus = "Monitoring"
            systemColor = "#44ff44"
        }
        
        function onHealthCheckPassed() {
            systemStatus = "Healthy"
            systemColor = "#44ff44"
        }
        
        function onSystemWarningActive() {
            systemStatus = "Warning"
            systemColor = "#ffaa00"
        }
        
        function onSystemCriticalError() {
            systemStatus = "Critical Error"
            systemColor = "#ff4444"
        }
        
        function onSystemShuttingDown() {
            systemStatus = "Shutting Down"
            systemColor = "#888888"
        }
    }
}
