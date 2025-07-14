import 'package:flutter/material.dart';

class HabitsController extends ChangeNotifier {
  final List<Map<String, dynamic>> habits = [
    {
      'id': '1',
      'title': 'Morning Meditation',
      'time': '7:00 AM',
      'isCompleted': false,
    },
    {
      'id': '2',
      'title': 'Read 30 minutes',
      'time': '8:00 AM',
      'isCompleted': true,
    },
    {
      'id': '3',
      'title': 'Exercise',
      'time': '6:00 PM',
      'isCompleted': false,
    },
  ];

  void toggleHabitCompletion(String habitId) {
    final habitIndex = habits.indexWhere((habit) => habit['id'] == habitId);
    if (habitIndex != -1) {
      habits[habitIndex]['isCompleted'] = !habits[habitIndex]['isCompleted'];
      notifyListeners();
    }
  }

  void addHabit(String title, String time) {
    habits.add({
      'id': DateTime.now().toString(),
      'title': title,
      'time': time,
      'isCompleted': false,
    });
    notifyListeners();
  }

  void deleteHabit(String habitId) {
    habits.removeWhere((habit) => habit['id'] == habitId);
    notifyListeners();
  }
}