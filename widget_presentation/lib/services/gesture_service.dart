import 'dart:math';
import 'package:flutter/material.dart';

/// Handles all gesture-related calculations and transformations
class GestureService {
  static const double minScale = 0.5;
  static const double maxScale = 3.0;
  static const double baseSize = 120.0;

  /// Generates a random color
  static Color generateRandomColor() {
    return Color(0xFF000000 | Random().nextInt(0x00FFFFFF));
  }

  /// Calculates new scale value within bounds
  static double calculateScale(double initialScale, double scaleFactor) {
    return (initialScale * scaleFactor).clamp(minScale, maxScale);
  }

  /// Calculates new center position with screen bounds clamping
  static Offset calculateNewCenter({
    required Offset initialCenter,
    required Offset focalPointDelta,
    required double currentScale,
    required Size screenSize,
  }) {
    final newCenter = initialCenter + focalPointDelta;
    return clampToScreen(
      center: newCenter,
      scale: currentScale,
      screenSize: screenSize,
    );
  }

  /// Clamps the box center to stay within screen bounds
  static Offset clampToScreen({
    required Offset center,
    required double scale,
    required Size screenSize,
  }) {
    final double half = baseSize * scale / 2;
    final double minX = half;
    final double maxX = screenSize.width - half;
    final double minY = half + 20;
    final double maxY = screenSize.height - half - 20;

    return Offset(center.dx.clamp(minX, maxX), center.dy.clamp(minY, maxY));
  }

  /// Determines gesture type from scale details
  static String detectGestureType(double scaleFactor) {
    return (scaleFactor - 1.0).abs() > 0.01 ? 'Pinch/Zoom' : 'Drag/Pan';
  }
}
