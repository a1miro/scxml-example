#include "Statemachine.h"
#include "MyModel.h"

Statemachine::Statemachine(MyModel *model, QObject *parent)
    : QObject(parent), m_model(model)
{
    m_scxml.setParent(this);
    m_scxml.setDataModel(model);
    connect(&m_scxml, &StatemachineScxml::activated, this, [this]() {
        // Forward to QML if needed
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
    QVariantMap params;
    params["value"] = value;
    m_scxml.submitEvent("update", params);
}
