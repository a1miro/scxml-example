#pragma once
#include <QObject>

class MyModel : public QObject {
    Q_OBJECT
    Q_PROPERTY(int value READ value WRITE setValue NOTIFY valueChanged)
public:
    explicit MyModel(QObject *parent = nullptr);
    int value() const;
    void setValue(int v);
signals:
    void valueChanged(int value);
public slots:
    void updateValue(int v);
private:
    int m_value = 0;
};
