# Qt6 QML/SCXML Example Application

## Overview
This project demonstrates a modern Qt6 application using QML for the UI, a C++ data model, and a compiled Qt SCXML state machine to control UI logic and event flow. It is built and packaged using CMake and CPACK, following best practices for Qt6 Quick and SCXML integration.

## Features
- **Qt6 QML UI**: The user interface is written in QML and loaded via Qt's module system (`qt_add_qml_module`).
- **C++ Data Model**: The `MyModel` class exposes a property (`value`) to QML, allowing two-way data binding and signal forwarding.
- **Compiled SCXML State Machine**: The state machine is defined in `statemachine.scxml`, compiled to C++ using `qt_add_statecharts` for type-safe, high-performance integration.
- **Event Forwarding**: QML UI events are forwarded to the state machine via invokable C++ methods, with parameters passed as event payloads.
- **State-Driven UI**: The SCXML state machine controls UI logic, transitions, and can update the data model based on events and scripts.
- **CMake Build**: Uses modern CMake functions (`qt_add_qml_module`, `qt_add_statecharts`) for resource management and build automation.
- **CPACK Packaging**: Generates both Debian (`.deb`) and tarball (`.tar.gz`) packages, with all required libraries bundled for easy distribution.

## How It Works
1. **Startup**: `main.cpp` creates the QML engine, exposes the C++ model and state machine to QML, and loads the main QML file using the module URI.
2. **QML UI**: The UI displays the current value and provides buttons to trigger state machine events (`start`, `stop`, `update`).
3. **Event Handling**: When a button is pressed, QML calls a method on the C++ state machine wrapper, which submits an event (with parameters) to the SCXML engine.
4. **SCXML Logic**: The state machine transitions between states (`idle`, `active`), runs scripts to update internal variables, and can trigger signals or update the C++ model.
5. **Data Model Sync**: The C++ model is updated directly by the state machine wrapper, and QML reflects changes via property bindings.
6. **Packaging**: All required libraries are installed alongside the executable, and CPACK can generate installable packages for Linux.

## Key Qt6 SCXML Features Used
- **qt_add_statecharts**: Compiles SCXML files to C++ classes for type-safe integration.
- **QScxmlStateMachine**: Provides the runtime for executing state machines, handling events, and transitions.
- **SCXML Data Model**: Uses `<datamodel>` and `<script>` elements to store and manipulate variables within the state machine.
- **Event Payloads**: Passes parameters from QML to SCXML via event data maps, enabling rich event-driven logic.
- **QML Module System**: Uses `qt_add_qml_module` to bundle QML files and expose them via module URIs and resource paths.

## Build & Run Instructions
```bash
# Configure and build
cmake -S . -B build
cmake --build build -j

# Install to a directory (with all required libraries)
cmake --install build --prefix install-dir

# Run the app
cd install-dir/bin
./SCXMLExampleApp
```

## Packaging
To generate Debian and tarball packages:
```bash
cd build
cpack
```
Packages will be created in the build directory.

## Customization & Extension
- Add more states and transitions in `statemachine.scxml` to model complex UI logic.
- Expose additional properties or signals from the C++ model to QML.
- Use SCXML scripts to perform calculations or trigger custom events.
- Integrate with other Qt modules (e.g., networking, database) as needed.

## Troubleshooting
- If you see missing library errors, ensure Qt6 runtime libraries are installed or set `LD_LIBRARY_PATH` to include Qt6 libs.
- If QML files are not found, verify that `qt_add_qml_module` is used and the module URI matches the load path in C++.
- For advanced packaging (AppImage, Flatpak), consider using `linuxdeployqt` or other tools.

## References
- [Qt SCXML Documentation](https://doc.qt.io/qt-6/qtqmlstatemachine-index.html)
- [Qt QML Module System](https://doc.qt.io/qt-6/qtqml-modules-topic.html)
- [CMake Qt6 Integration](https://doc.qt.io/qt-6/cmake-manual.html)
