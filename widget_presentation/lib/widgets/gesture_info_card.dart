import 'package:flutter/material.dart';

/// Displays gesture instructions and current state
class GestureInfoCard extends StatelessWidget {
  final String lastGesture;
  final double displaySize;

  const GestureInfoCard({
    super.key,
    required this.lastGesture,
    required this.displaySize,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Last: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(child: Text(lastGesture)),
                const SizedBox(width: 8),
                Text(
                  'Size: ${displaySize.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
