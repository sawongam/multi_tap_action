import 'package:flutter/material.dart';
import 'package:multi_tap_action/multi_tap_action.dart';
import 'package:multi_tap_action/src/constants/enums.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Multi Tap Action Example'),
        ),
        body: Center(
          child: MultiTapAction(
            taps: 3, // Number of taps required to trigger the action
            resetDuration: const Duration(seconds: 5),
            onActionTriggered: (int taps) {
              // Action triggered when the required number of taps is detected
              print('$taps taps detected!');
            },
            onTap: (int count) {
              // Action triggered on each tap
              print('Current tap count: $count');
            },
            enableHapticFeedback: true, // Enable haptic feedback
            hapticFeedbackType:
                HapticFeedbackType.mediumImpact, // Haptic feedback type
            child: const Text('Tap 5 times!'),
          ),
        ),
      ),
    );
  }
}
