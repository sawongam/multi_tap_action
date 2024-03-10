# Multi Tap Action
![Pub](https://img.shields.io/badge/Pub-0.0.1-blue.svg)
![Publisher](https://img.shields.io/badge/Publisher-sawongam-blue.svg)

## Features

- **Specify the desired number of taps:** Define the exact number of taps required to trigger an action.
- Perform custom actions: Upon reaching the specified number of taps, execute any desired action.
- Simple integration: The package integrates seamlessly with your existing widgets using the familiar GestureDetector widget.

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

```dart
MultiTapAction(
    taps: 3, // Number of taps to detect
    action: () {
    // Action to perform when the specified number of taps is reached
    print('Triple tap detected!');
    },
    child: Container(
    // Your child widget
    color: Colors.blue,
    width: 100,
    height: 100,
),
)
```

## Constructor

| Parameters                  | Type                 | Description                                                                |
|-----------------------------|----------------------|----------------------------------------------------------------------------|
| __taps__                    | int                  | Number of taps required to trigger the action.                             |
| __action__                  | VoidCallback         | Custom action to perform when the specified number of taps is detected.    |
| __child__                   | Widget               | Widget on which taps are detected.                                         |

## Author

This package was developed by [sawongam](https://github.com/sawongam)