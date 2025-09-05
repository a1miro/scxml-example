#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "MyModel.h"
#include "Statemachine.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    MyModel model;
    Statemachine statemachine(&model);

    engine.rootContext()->setContextProperty("myModel", &model);
    engine.rootContext()->setContextProperty("statemachine", &statemachine);

    statemachine.start();

    engine.load(QUrl(QStringLiteral("qrc:/qml/Main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
