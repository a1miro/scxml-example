#include "smwrapper.h"
#include "MyModel.h"
#include <QTimer>

Statemachine::Statemachine(MyModel *model, QObject *parent)
    : QObject(parent), m_model(model)
{
    m_scxml.setParent(this);
    connectAllEvents();
}

void Statemachine::connectAllEvents() {
    // Legacy events (for compatibility)
    m_scxml.connectToEvent("activated", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit activated();
    });

    m_scxml.connectToEvent("idled", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit idled();
    });
    
    // Connection status events
    m_scxml.connectToEvent("connection.status.changed", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit connectionStatusChanged();
    });
    
    m_scxml.connectToEvent("connection.attempting", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit connectionAttempting();
    });
    
    m_scxml.connectToEvent("connection.established", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit connectionEstablished();
    });
    
    m_scxml.connectToEvent("connection.reconnecting", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit connectionReconnecting();
    });
    
    m_scxml.connectToEvent("connection.error", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit connectionError();
    });
    
    m_scxml.connectToEvent("connection.offline", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit connectionOffline();
    });
    
    // Data processing events
    m_scxml.connectToEvent("processing.idle", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit processingIdle();
    });
    
    m_scxml.connectToEvent("processing.started", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit processingStarted();
    });
    
    m_scxml.connectToEvent("data.processed", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit dataProcessed();
    });
    
    m_scxml.connectToEvent("processing.completing", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit processingCompleting();
    });
    
    m_scxml.connectToEvent("processing.error", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit processingError();
    });
    
    // User interface events
    m_scxml.connectToEvent("ui.waiting", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit uiWaiting();
    });
    
    m_scxml.connectToEvent("ui.active", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit uiActive();
    });
    
    m_scxml.connectToEvent("ui.authenticated", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit uiAuthenticated();
    });
    
    m_scxml.connectToEvent("user.action.processed", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit userActionProcessed();
    });
    
    m_scxml.connectToEvent("user.authenticated.action", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit userAuthenticatedAction();
    });
    
    // System monitoring events
    m_scxml.connectToEvent("monitor.started", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit monitorStarted();
    });
    
    m_scxml.connectToEvent("health.check.passed", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit healthCheckPassed();
    });
    
    m_scxml.connectToEvent("system.warning.active", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit systemWarningActive();
    });
    
    m_scxml.connectToEvent("system.critical.error", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit systemCriticalError();
    });
    
    m_scxml.connectToEvent("system.shutting.down", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit systemShuttingDown();
    });
}

void Statemachine::start() {
    m_scxml.start();
}

// Connection Management Methods
void Statemachine::connectToNetwork() {
    m_scxml.submitEvent("connect");
}

void Statemachine::disconnectFromNetwork() {
    m_scxml.submitEvent("disconnect");
}

void Statemachine::simulateConnectionSuccess() {
    m_scxml.submitEvent("connection.success");
}

void Statemachine::simulateConnectionFailure() {
    m_scxml.submitEvent("connection.failed");
}

void Statemachine::simulateConnectionLost() {
    m_scxml.submitEvent("connection.lost");
}

void Statemachine::retryConnection() {
    m_scxml.submitEvent("retry.connection");
}

// Data Processing Methods
void Statemachine::startProcessing() {
    m_scxml.submitEvent("start.processing");
}

void Statemachine::stopProcessing() {
    m_scxml.submitEvent("stop.processing");
}

void Statemachine::sendUpdate(int value) {
    // Update model immediately (UI responsiveness) and submit event carrying value
    m_model->setValue(value);
    QVariantMap params;
    params["value"] = value;
    m_scxml.submitEvent("update", params);
}

void Statemachine::simulateDataBatch() {
    m_scxml.submitEvent("data.batch.received");
}

void Statemachine::simulateProcessingError() {
    m_scxml.submitEvent("process.error");
}

void Statemachine::completeDataProcessing() {
    m_scxml.submitEvent("data.complete");
    // Simulate completion after a short delay
    QTimer::singleShot(1000, [this]() {
        m_scxml.submitEvent("completion.done");
    });
}

void Statemachine::resetProcessing() {
    m_scxml.submitEvent("reset.processing");
}

// User Interaction Methods
void Statemachine::simulateUserInteraction() {
    m_scxml.submitEvent("user.interaction");
}

void Statemachine::simulateUserLogin() {
    m_scxml.submitEvent("user.login");
}

void Statemachine::simulateUserLogout() {
    m_scxml.submitEvent("user.logout");
}

void Statemachine::simulateUserAction() {
    m_scxml.submitEvent("user.action");
}

void Statemachine::simulateUserIdle() {
    m_scxml.submitEvent("user.idle");
}

void Statemachine::simulateSessionTimeout() {
    m_scxml.submitEvent("session.timeout");
}

// System Monitoring Methods
void Statemachine::reportSystemHealthy() {
    m_scxml.submitEvent("system.healthy");
}

void Statemachine::reportSystemWarning() {
    m_scxml.submitEvent("system.warning");
}

void Statemachine::reportSystemCritical() {
    m_scxml.submitEvent("system.critical");
}

void Statemachine::acknowledgeWarning() {
    m_scxml.submitEvent("warning.acknowledged");
}

void Statemachine::initiateSystemRecovery() {
    m_scxml.submitEvent("system.recovery");
}

void Statemachine::shutdownSystem() {
    m_scxml.submitEvent("system.shutdown");
}

void Statemachine::restartSystem() {
    m_scxml.submitEvent("system.restart");
}
