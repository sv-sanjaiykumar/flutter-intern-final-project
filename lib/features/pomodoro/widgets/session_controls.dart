import 'package:flutter/material.dart';

class SessionControls extends StatelessWidget {
  final bool isRunning;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onReset;

  const SessionControls({
    super.key,
    required this.isRunning,
    required this.onStart,
    required this.onPause,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          onPressed: isRunning ? onPause : onStart,
          child: Icon(isRunning ? Icons.pause : Icons.play_arrow),
        ),
        const SizedBox(width: 20),
        FloatingActionButton(
          onPressed: onReset,
          child: const Icon(Icons.replay),
        ),
      ],
    );
  }
}