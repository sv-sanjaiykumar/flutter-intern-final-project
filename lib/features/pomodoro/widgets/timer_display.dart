import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  final int timeLeft;
  final bool isBreak;
  final bool isLongBreak;

  const TimerDisplay({
    super.key,
    required this.timeLeft,
    required this.isBreak,
    required this.isLongBreak,
  });

  @override
  Widget build(BuildContext context) {
    final minutes = (timeLeft / 60).floor();
    final seconds = timeLeft % 60;

    Color borderColor = Colors.transparent;
    if (isBreak) {
      borderColor = isLongBreak 
          ? Colors.orange 
          : Theme.of(context).colorScheme.primary;
    }

    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: borderColor,
          width: 4,
        ),
      ),
      child: Center(
        child: Text(
          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: isBreak 
                    ? (isLongBreak 
                        ? Colors.orange 
                        : Theme.of(context).colorScheme.primary)
                    : Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}