# Multi Tap Action
![Pub](https://img.shields.io/badge/Pub-2.1.0-blue.svg)
![Publisher](https://img.shields.io/badge/Publisher-sawongam-blue.svg)

## Features

- **Customizable tap count:** Define the exact number of taps required to trigger an action
- **Custom actions:** Execute any desired action when the specified number of taps is reached
- **Haptic feedback:** Optionally enable haptic feedback with different types (light, medium, heavy, or selection click)
- **Tap reset duration:** Set a time window to reset the tap counter if no further taps are detected
- **Callback for every tap:** Get the current tap count on every tap for additional control.


## Getting started

Install it using pub:
```yaml
flutter pub add multi_tap_action
```

And import the package:
```dart
import 'package:multi_tap_action/multi_tap_action.dart';
```

## Usage

### Basic Example

Detect a triple tap and perform an action:

```dart
MultiTapAction(
  taps: 3, // Number of taps to detect
  onActionTriggered: (taps) {
    print('$taps taps detected!'); // Action to perform when the specified number of taps is reached
  },
  child: Container(
    color: Colors.yellow,
    width: 100,
    height: 100,
  ),
)
```

### Advanced Example

Detect a double tap with haptic feedback and a custom reset duration:

```dart
MultiTapAction(
  taps: 2,
  onActionTriggered: (taps) {
    print('$taps taps detected!');
  },
  onTap: (currentTapCount) {
    print('Current tap count: $currentTapCount');
  },
  resetDuration: Duration(seconds: 2), // Reset tap counter after 2 seconds
  enableHapticFeedback: true, // Enable haptic feedback
  hapticFeedbackType: HapticFeedbackType.mediumImpact, // Use medium impact haptic feedback
  child: Container(
    color: Colors.red,
    width: 150,
    height: 150,
  ),
)
```


## Constructor

| Parameters                          | Type                           | Description                                                                   |
|-------------------------------------|--------------------------------|-------------------------------------------------------------------------------|
| __taps__                            | int                            | Number of taps required to trigger the action. Must be greater than 0.        |
| __onActionTriggered__               | Function(int taps)             | Callback function to execute when the specified number of taps is reached.    |
| __child__                           | Widget                         | The widget on which taps are detected.                                        |
| __onTap (optional)__                | Function(int currentTapCount)? | Callback function to execute on every tap. Returns the current tap count.     |
| __resetDuration (optional)__        | Duration                       | Time to reset if no further taps are detected.Defaults to 60seconds.          |
| __enableHapticFeedback (optional)__ | bool                           | Enable haptic feedback when the action is triggered. Defaults to false.       |
| __hapticFeedbackType (optional)__   | HapticFeedbackType             | Type of haptic feedback to trigger. Defaults toHapticFeedbackType.lightImpact. |


## Author

This package was developed by [sawongam](https://github.com/sawongam)