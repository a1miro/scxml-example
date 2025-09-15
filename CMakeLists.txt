cmake_minimum_required(VERSION 3.16)
project(SCXMLExample LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick Qml Scxml)

qt_add_statecharts(SCXML_FILES statemachine.scxml)

add_executable(scxmlexample_app
    main.cpp
    MyModel.cpp
    Statemachine.cpp
    ${SCXML_FILES}
)

target_include_directories(scxmlexample_app PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_include_directories(scxmlexample_app PRIVATE ${CMAKE_BINARY_DIR})
target_link_libraries(scxmlexample_app PRIVATE Qt6::Core Qt6::Quick Qt6::Qml Qt6::Scxml)

qt_add_qml_module(scxmlexample_app
    URI SCXMLExample
    QML_FILES
        qml/Main.qml
)

set_target_properties(scxmlexample_app PROPERTIES OUTPUT_NAME SCXMLExampleApp)

install(TARGETS scxmlexample_app
    BUNDLE DESTINATION .
    RUNTIME DESTINATION bin
)
