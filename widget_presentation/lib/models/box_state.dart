import 'package:flutter/material.dart';

/// Represents the state of the interactive box
class BoxState {
  final Offset center;
  final double scale;
  final Color color;
  final String lastGesture;

  const BoxState({
    required this.center,
    this.scale = 1.0,
    required this.color,
    this.lastGesture = 'None',
  });

  BoxState copyWith({
    Offset? center,
    double? scale,
    Color? color,
    String? lastGesture,
  }) {
    return BoxState(
      center: center ?? this.center,
      scale: scale ?? this.scale,
      color: color ?? this.color,
      lastGesture: lastGesture ?? this.lastGesture,
    );
  }
}
