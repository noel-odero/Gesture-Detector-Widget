import 'package:flutter/material.dart';

/// Tracks gesture state during scaling operations
class GestureStateTracker {
  Offset initialFocalPoint = Offset.zero;
  Offset initialCenter = Offset.zero;
  double initialScale = 1.0;

  void capture(Offset focalPoint, Offset center, double scale) {
    initialFocalPoint = focalPoint;
    initialCenter = center;
    initialScale = scale;
  }
}
