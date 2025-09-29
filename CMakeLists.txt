# Install all required shared libraries for the executable (CMake >= 3.21)
install(CODE [[
    file(GET_RUNTIME_DEPENDENCIES
        EXECUTABLES "${CMAKE_INSTALL_PREFIX}/bin/SCXMLExampleApp"
        RESOLVED_DEPENDENCIES_VAR resolved_deps
        UNRESOLVED_DEPENDENCIES_VAR unresolved_deps
        DIRECTORIES
            /usr/lib/x86_64-linux-gnu
            /usr/local/lib
            $ENV{LD_LIBRARY_PATH}
    )
    foreach(dep IN LISTS resolved_deps)
        file(INSTALL
            DESTINATION "${CMAKE_INSTALL_PREFIX}/bin"
            TYPE SHARED_LIBRARY
            FILES "${dep}"
        )
    endforeach()
]])
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
    smwrapper.cpp
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


# CPACK configuration
set(CPACK_PACKAGE_NAME "scxml-example-app")
set(CPACK_PACKAGE_VENDOR "YourCompany")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Qt6 QML/SCXML Example Application")
set(CPACK_PACKAGE_VERSION "1.0.0")
set(CPACK_PACKAGE_CONTACT "your@email.com")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Your Name")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "qt6-base, qt6-declarative, qt6-scxml")
set(CPACK_DEBIAN_PACKAGE_SECTION "utils")
set(CPACK_DEBIAN_PACKAGE_PRIORITY "optional")
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "amd64")
set(CPACK_GENERATOR "DEB;TGZ")
set(CPACK_PACKAGE_FILE_NAME "scxml-example-app-${CPACK_PACKAGE_VERSION}")
include(CPack)
