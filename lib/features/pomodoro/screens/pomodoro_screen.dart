import 'package:flutter/material.dart';
import '../controllers/pomodoro_controller.dart';
import '../widgets/timer_display.dart';
import '../widgets/session_controls.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  final _pomodoroController = PomodoroController();

  void _showTimerSettingsDialog() {
    final workController = TextEditingController(
      text: _pomodoroController.workTime.toString(),
    );
    final shortBreakController = TextEditingController(
      text: _pomodoroController.shortBreakTime.toString(),
    );
    final longBreakController = TextEditingController(
      text: _pomodoroController.longBreakTime.toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Timer Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: workController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Work Time (minutes)',
                hintText: 'Enter work time',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: shortBreakController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Short Break (minutes)',
                hintText: 'Enter short break time',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: longBreakController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Long Break (minutes)',
                hintText: 'Enter long break time',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final workTime = int.tryParse(workController.text);
              final shortBreak = int.tryParse(shortBreakController.text);
              final longBreak = int.tryParse(longBreakController.text);

              if (workTime != null && workTime > 0) {
                _pomodoroController.setWorkTime(workTime);
              }
              if (shortBreak != null && shortBreak > 0) {
                _pomodoroController.setShortBreakTime(shortBreak);
              }
              if (longBreak != null && longBreak > 0) {
                _pomodoroController.setLongBreakTime(longBreak);
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pomodoroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Pomodoro Timer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showTimerSettingsDialog,
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _pomodoroController,
        builder: (context, child) {
          String sessionText;
          if (_pomodoroController.isBreak) {
            sessionText = _pomodoroController.isLongBreak 
                ? 'Long Break Time!' 
                : 'Short Break Time!';
          } else {
            sessionText = 'Work Session ${_pomodoroController.currentSession}';
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  sessionText,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: _pomodoroController.isBreak 
                      ? (_pomodoroController.isLongBreak 
                          ? Colors.orange 
                          : Theme.of(context).colorScheme.primary)
                      : null,
                  ),
                ),
                const SizedBox(height: 20),
                TimerDisplay(
                  timeLeft: _pomodoroController.timeLeft,
                  isBreak: _pomodoroController.isBreak,
                  isLongBreak: _pomodoroController.isLongBreak,
                ),
                const SizedBox(height: 40),
                SessionControls(
                  isRunning: _pomodoroController.isRunning,
                  onStart: _pomodoroController.startTimer,
                  onPause: _pomodoroController.pauseTimer,
                  onReset: _pomodoroController.resetTimer,
                ),
                if (!_pomodoroController.isBreak) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Completed Sessions: ${_pomodoroController.completedSessions}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}