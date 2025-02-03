library multi_tap_action;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MultiTapAction extends StatefulWidget {
  /// Number of taps required to execute the action
  final int taps;

  /// Callback function to execute when tap count is reached. It will return the number of taps needed to trigger the action.
  final Function(int taps) onActionTriggered;

  /// Child widget to apply tap detection to
  final Widget child;

  /// Time window to count taps within
  final Duration resetDuration;

  /// Enable haptic feedback on action trigger
  final bool enableHapticFeedback;

  const MultiTapAction({
    super.key,
    required this.taps,
    required this.onActionTriggered,
    required this.child,
    this.resetDuration = const Duration(minutes: 1),
    this.enableHapticFeedback = false,
  }) : assert(taps > 0, 'tapsRequired must be greater than 0');

  @override
  State<MultiTapAction> createState() => _MultiTapActionState();
}

class _MultiTapActionState extends State<MultiTapAction> {
  int _tapCounter = 0;
  DateTime? _lastTapTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: widget.child,
    );
  }

  void _handleTap() {
    final now = DateTime.now();

    if (_lastTapTime != null &&
        now.difference(_lastTapTime!) > widget.resetDuration) {
      setState(() {
        _tapCounter = 0;
      });
    }

    setState(() {
      _tapCounter++;
      _lastTapTime = now;
    });

    if (_tapCounter == widget.taps) {
      widget.onActionTriggered(_tapCounter);
      if (widget.enableHapticFeedback) {
        _triggerHapticFeedback();
      }
      setState(() {
        _tapCounter = 0;
      });
    }
  }

  void _triggerHapticFeedback() {
    HapticFeedback.lightImpact();
  }
}
