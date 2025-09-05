cmake_minimum_required(VERSION 3.16)
project(SCXMLExample LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick Qml Scxml)

qt_add_statecharts(SCXML_FILES statemachine.scxml)

add_executable(SCXMLExample
    main.cpp
    MyModel.cpp
    Statemachine.cpp
    ${SCXML_FILES}
)

target_include_directories(SCXMLExample PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(SCXMLExample PRIVATE Qt6::Core Qt6::Quick Qt6::Qml Qt6::Scxml)

qt_add_qml_module(SCXMLExample
    URI SCXMLExample
    QML_FILES
        qml/Main.qml
)

install(TARGETS SCXMLExample
    BUNDLE DESTINATION .
    RUNTIME DESTINATION bin
)
