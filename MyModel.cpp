#include "MyModel.h"

MyModel::MyModel(QObject *parent) : QObject(parent) {}

int MyModel::value() const { return m_value; }

void MyModel::setValue(int v) {
    if (m_value != v) {
        m_value = v;
        emit valueChanged(m_value);
    }
}

void MyModel::updateValue(int v) {
    setValue(v);
}
