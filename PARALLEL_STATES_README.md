# SCXML Parallel States Demo

This Qt6 QML application demonstrates advanced SCXML features including **parallel states** for managing concurrent processes. The state machine handles multiple independent aspects of a system simultaneously.

## Features Demonstrated

### 1. Parallel State Architecture
The SCXML state machine uses a `<parallel>` container that allows four independent state machines to run concurrently:

- **Connection Management** - Network/device connectivity
- **Data Processing** - Background data operations  
- **User Interface** - User interaction and authentication
- **System Monitoring** - Overall system health monitoring

### 2. Connection Management States
- `disconnected` → `connecting` → `connected`
- `reconnecting` when connection is lost
- `connection_error` after multiple failed attempts
- `offline` when system is shutdown

### 3. Data Processing States
- `idle` → `active` → `completing` → `idle`
- `error` state with retry capability
- Tracks processed items and error counts

### 4. User Interface States
- `ui_waiting` → `ui_active` → `authenticated`
- Automatic idle timeouts
- Session timeout handling
- User action tracking

### 5. System Monitoring States  
- `monitoring` (healthy) → `warning` → `critical` → `shutdown`
- Health check monitoring
- Recovery mechanisms

## Advanced SCXML Features Used

### Data Model
```xml
<datamodel>
  <data id="value" expr="0"/>
  <data id="connectionAttempts" expr="0"/>
  <data id="processedItems" expr="0"/>
  <data id="errorCount" expr="0"/>
  <data id="isUserActive" expr="false"/>
</datamodel>
```

### Conditional Transitions
```xml
<transition event="connection.failed" target="disconnected" cond="connectionAttempts &lt; 3"/>
<transition event="connection.failed" target="connection_error" cond="connectionAttempts >= 3"/>
```

### State Entry Actions
```xml
<onentry>
  <assign location="connectionAttempts" expr="connectionAttempts + 1"/>
  <send event="connection.attempting" delay="100ms"/>
</onentry>
```

### Event Parameters
```xml
<transition event="update" target="active">
  <assign location="value" expr="_event.data.value"/>
  <assign location="processedItems" expr="processedItems + 1"/>
  <send event="data.processed" delay="100ms"/>
</transition>
```

## Benefits of Parallel States

1. **Separation of Concerns**: Each parallel region handles distinct responsibilities
2. **Independent Operation**: States can transition independently without affecting others
3. **Simplified Logic**: Avoids complex conditional logic for orthogonal behaviors
4. **Real-world Modeling**: Better represents actual concurrent systems
5. **Maintainability**: Changes to one region don't impact others

## User Interface

The demo provides a comprehensive control panel with:

- **Status Dashboard**: Visual indicators for all four parallel state machines
- **Connection Controls**: Connect, disconnect, simulate failures
- **Processing Controls**: Start/stop processing, send data updates
- **User Interaction**: Login/logout, user actions, idle simulation
- **System Monitoring**: Health reports, warnings, recovery actions

## Running the Demo

1. Build the project: `cmake --build build`
2. Run the executable: `./build/SCXMLExampleApp`
3. Use the various buttons to trigger state transitions
4. Observe how the four parallel regions operate independently
5. Watch the status dashboard update in real-time

## Technical Implementation

- **SCXML File**: `statemachine.scxml` - Defines the parallel state machine
- **C++ Wrapper**: `smwrapper.h/cpp` - Qt interface to the SCXML engine
- **QML UI**: `qml/Main.qml` - Interactive demonstration interface
- **Data Model**: `MyModel.h/cpp` - Application data handling

This demo showcases how SCXML parallel states can model complex, real-world systems with multiple concurrent concerns, making state management more intuitive and maintainable.