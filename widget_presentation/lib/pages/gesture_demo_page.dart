import 'package:flutter/material.dart';
import '../models/box_state.dart'; //box state
import '../models/gesture_state_tracker.dart'; //gesture state
import '../services/gesture_service.dart'; // logic -scale, clamping, random color, detection of gesture type
import '../widgets/gesture_info_card.dart'; // to show the current gesture and box size
import '../widgets/interactive_box.dart'; // this is the box widget

class GestureDemoPage extends StatefulWidget {
  const GestureDemoPage({super.key});

  @override
  State<GestureDemoPage> createState() => _GestureDemoPageState();
}

class _GestureDemoPageState extends State<GestureDemoPage> {
  late BoxState boxState;
  final GestureStateTracker _gestureTracker = GestureStateTracker();

  @override
  void initState() {
    super.initState();
    boxState = BoxState(center: Offset.zero, color: Colors.pinkAccent);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (boxState.center == Offset.zero) {
      final Size size = MediaQuery.of(context).size;
      setState(() {
        boxState = boxState.copyWith(
          center: Offset(size.width / 2, size.height / 2 - 80),
        );
      });
    }
  }

  //  Gesture Handlers

  void _handleTap() {
    setState(() {
      boxState = boxState.copyWith(
        color: GestureService.generateRandomColor(),
        lastGesture: 'Tap → color changed',
      );
    });
  }

  void _handleDoubleTap() {
    final bool isNormalSize = (boxState.scale - 1.0).abs() < 0.1;
    setState(() {
      boxState = boxState.copyWith(
        scale: isNormalSize ? 1.6 : 1.0,
        lastGesture: isNormalSize
            ? 'Double tap → zoomed'
            : 'Double tap → zoom reset',
      );
    });
  }

  void _handleLongPress() {
    final Size screenSize = MediaQuery.of(context).size;
    setState(() {
      boxState = boxState.copyWith(
        center: Offset(screenSize.width / 2, screenSize.height / 2 - 80),
        scale: 1.0,
        lastGesture: 'Long press → reset',
      );
    });
    _showSnackBar('Box reset to center');
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _gestureTracker.capture(
      details.focalPoint,
      boxState.center,
      boxState.scale,
    );
    setState(() {
      boxState = boxState.copyWith(lastGesture: 'Scale start');
    });
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    final newScale = GestureService.calculateScale(
      _gestureTracker.initialScale,
      details.scale,
    );

    final focalDelta = details.focalPoint - _gestureTracker.initialFocalPoint;
    final newCenter = GestureService.calculateNewCenter(
      initialCenter: _gestureTracker.initialCenter,
      focalPointDelta: focalDelta,
      currentScale: newScale,
      screenSize: MediaQuery.of(context).size,
    );

    setState(() {
      boxState = boxState.copyWith(
        scale: newScale,
        center: newCenter,
        lastGesture: GestureService.detectGestureType(details.scale),
      );
    });
  }

  void _handleScaleEnd(ScaleEndDetails details) {
    setState(() {
      boxState = boxState.copyWith(lastGesture: 'Gesture End');
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }

  // UI

  @override
  Widget build(BuildContext context) {
    final double displaySize = GestureService.baseSize * boxState.scale;

    return Scaffold(
      appBar: AppBar(title: const Text('GestureDetector Demo')),
      body: Stack(
        children: [
          // Info card
          Positioned(
            left: 12,
            right: 12,
            top: 12,
            child: GestureInfoCard(
              lastGesture: boxState.lastGesture,
              displaySize: displaySize,
            ),
          ),

          // Interactive box
          Positioned(
            left: boxState.center.dx - displaySize / 2,
            top: boxState.center.dy - displaySize / 2,
            child: InteractiveBox(
              size: displaySize,
              color: boxState.color,
              onTap: _handleTap,
              onDoubleTap: _handleDoubleTap,
              onLongPress: _handleLongPress,
              onScaleStart: _handleScaleStart,
              onScaleUpdate: _handleScaleUpdate,
              onScaleEnd: _handleScaleEnd,
            ),
          ),
        ],
      ),
    );
  }
}
