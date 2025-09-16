#include "Statemachine.h"
#include "MyModel.h"

Statemachine::Statemachine(MyModel *model, QObject *parent)
    : QObject(parent), m_model(model)
{
    m_scxml.setParent(this);
    // Listen for the 'activated' event and emit activated signal
    m_scxml.connectToEvent("activated", [this](const QScxmlEvent &event) {
        Q_UNUSED(event);
        emit activated();
    });
}

void Statemachine::start() {
    m_scxml.start();
}

void Statemachine::sendStart() {
    m_scxml.submitEvent("start");
}

void Statemachine::sendStop() {
    m_scxml.submitEvent("stop");
}

void Statemachine::sendUpdate(int value) {
    // Update model immediately (UI responsiveness) and submit event carrying value
    m_model->setValue(value);
    QVariantMap params;
    params["value"] = value;
    m_scxml.submitEvent("update", params);
}
