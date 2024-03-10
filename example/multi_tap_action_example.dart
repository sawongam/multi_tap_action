import 'package:flutter/material.dart';
import 'package:multi_tap_action/multi_tap_action.dart';

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
            taps: 3, // Number of taps to trigger the action
            action: () {
              // Custom action to perform when the specified number of taps is detected
              print('Triple tap detected!');
            },
            child: Container(
              width: 200,
              height: 200,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  'Tap Me!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
