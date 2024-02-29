library multi_tap_action;

import 'package:flutter/material.dart';

class MultiTapAction extends StatefulWidget {
  final int taps;
  final VoidCallback action;
  final Widget child;

  const MultiTapAction(
      {required this.taps,
      required this.action,
      required this.child,
      super.key});

  @override
  State<MultiTapAction> createState() => _MultiTapActionState();
}

class _MultiTapActionState extends State<MultiTapAction> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _counter++;
          if (_counter == widget.taps) {
            widget.action();
            _counter = 0;
          }
        });
      },
      child: widget.child,
    );
  }
}
