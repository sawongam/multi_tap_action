library multi_tap_action;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_tap_action/src/utils/haptic_feedback_utils.dart';
import 'constants/app_text.dart';
import 'constants/enums.dart';

/// A widget that detects a specific number of taps on a child widget and triggers an action.
class MultiTapAction extends StatefulWidget {
  /// Number of taps required to execute the action.
  final int taps;

  /// Callback function to execute when tap count is reached.
  /// It will return the number of taps needed to trigger the action.
  final Function(int taps) onActionTriggered;

  /// Callback function to execute on every tap.
  /// It will return the current tap count.
  final Function(int currentTapCount)? onTap;

  /// Child widget to apply tap detection to.
  final Widget child;

  /// Time window to count taps within.
  final Duration resetDuration;

  /// Enable haptic feedback on action trigger.
  final bool enableHapticFeedback;

  /// Type of haptic feedback to trigger (defaults to light impact).
  final HapticFeedbackType hapticFeedbackType;

  const MultiTapAction({
    super.key,
    required this.taps,
    required this.onActionTriggered,
    required this.child,
    this.onTap,
    this.resetDuration = const Duration(seconds: 60),
    this.enableHapticFeedback = false,
    this.hapticFeedbackType = HapticFeedbackType.lightImpact,
  }) : assert(taps > 0, AppText.tapValidationText);

  @override
  State<MultiTapAction> createState() => _MultiTapActionState();
}

class _MultiTapActionState extends State<MultiTapAction> {
  final ValueNotifier<int> _tapCounter = ValueNotifier(0);
  Timer? _resetTimer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _tapCounter.dispose();
    _resetTimer?.cancel();
    super.dispose();
  }

  void _handleTap() {
    // Cancel the previous timer if it exists.
    _resetTimer?.cancel();

    // Increment the tap counter.
    _tapCounter.value++;

    // Notify the onTap callback if provided.
    widget.onTap?.call(_tapCounter.value);

    // Check if the tap count matches the required number of taps.
    if (_tapCounter.value == widget.taps) {
      widget.onActionTriggered(_tapCounter.value);

      // Trigger haptic feedback if enabled.
      if (widget.enableHapticFeedback) {
        HapticFeedbackUtils.triggerHapticFeedback(widget.hapticFeedbackType);
      }

      // Reset the tap counter.
      _resetTapCounter();
    }

    // Start a new timer to reset the tap counter if no further taps occur.
    _resetTimer = Timer(widget.resetDuration, _resetTapCounter);
  }

  void _resetTapCounter() => _tapCounter.value = 0;
}
