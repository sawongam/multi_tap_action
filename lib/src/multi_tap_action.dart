library multi_tap_action;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/app_text.dart';
import 'constants/enums.dart';

class MultiTapAction extends StatefulWidget {
  /// Number of taps required to execute the action
  final int taps;

  /// Callback function to execute when tap count is reached.
  /// It will return the number of taps needed to trigger the action.
  final Function(int taps) onActionTriggered;

  /// Callback function to execute on every tap.
  /// It will return the current tap count.
  final Function(int currentTapCount)? onTap;

  /// Child widget to apply tap detection to
  final Widget child;

  /// Time window to count taps within
  final Duration resetDuration;

  /// Enable haptic feedback on action trigger
  final bool enableHapticFeedback;

  /// Type of haptic feedback to trigger (defaults to light impact)
  final HapticFeedbackType hapticFeedbackType;

  const MultiTapAction({
    super.key,
    required this.taps,
    required this.onActionTriggered,
    required this.child,
    this.onTap,
    this.resetDuration = const Duration(seconds: 2),
    this.enableHapticFeedback = false,
    this.hapticFeedbackType = HapticFeedbackType.lightImpact,
  }) : assert(taps > 0, AppText.tapValidationText);

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
      _resetTapCounter();
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
      return _resetTapCounter();
    }

    widget.onTap?.call(_tapCounter);
  }

  void _resetTapCounter() {
    setState(() {
      _tapCounter = 0;
    });
  }

  void _triggerHapticFeedback() {
    switch (widget.hapticFeedbackType) {
      case HapticFeedbackType.lightImpact:
        HapticFeedback.lightImpact();
        break;
      case HapticFeedbackType.mediumImpact:
        HapticFeedback.mediumImpact();
        break;
      case HapticFeedbackType.heavyImpact:
        HapticFeedback.heavyImpact();
        break;
      case HapticFeedbackType.selectionClick:
        HapticFeedback.selectionClick();
        break;
    }
  }
}
