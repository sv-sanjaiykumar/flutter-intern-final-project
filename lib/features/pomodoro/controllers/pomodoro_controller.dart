import 'dart:async';
import 'package:flutter/material.dart';

class PomodoroController extends ChangeNotifier {
  Timer? _timer;
  int _timeLeft = 25 * 60;
  bool _isRunning = false;
  int _completedSessions = 0;
  int _currentSession = 1;
  bool _isBreak = false;
  bool _isLongBreak = false;
  
  // Session types
  int _workTime = 25 * 60;
  int _shortBreak = 5 * 60;
  int _longBreak = 15 * 60;
  
  // Getters
  int get timeLeft => _timeLeft;
  bool get isRunning => _isRunning;
  int get completedSessions => _completedSessions;
  int get currentSession => _currentSession;
  bool get isBreak => _isBreak;
  bool get isLongBreak => _isLongBreak;
  int get workTime => _workTime ~/ 60;
  int get shortBreakTime => _shortBreak ~/ 60;
  int get longBreakTime => _longBreak ~/ 60;

  void setWorkTime(int minutes) {
    if (minutes > 0) {
      _workTime = minutes * 60;
      if (!_isBreak && !_isRunning) {
        _timeLeft = _workTime;
      }
      notifyListeners();
    }
  }

  void setShortBreakTime(int minutes) {
    if (minutes > 0) {
      _shortBreak = minutes * 60;
      if (_isBreak && !_isLongBreak && !_isRunning) {
        _timeLeft = _shortBreak;
      }
      notifyListeners();
    }
  }

  void setLongBreakTime(int minutes) {
    if (minutes > 0) {
      _longBreak = minutes * 60;
      if (_isBreak && _isLongBreak && !_isRunning) {
        _timeLeft = _longBreak;
      }
      notifyListeners();
    }
  }

  void startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_timeLeft > 0) {
          _timeLeft--;
          notifyListeners();
        } else {
          _timer?.cancel();
          _isRunning = false;
          
          if (!_isBreak) {
            _completedSessions++;
            _isBreak = true;
            if (_completedSessions % 4 == 0) {
              _isLongBreak = true;
              _timeLeft = _longBreak;
            } else {
              _isLongBreak = false;
              _timeLeft = _shortBreak;
            }
          } else {
            _isBreak = false;
            _isLongBreak = false;
            _timeLeft = _workTime;
            _currentSession++;
          }
          notifyListeners();
        }
      });
    }
  }

  void pauseTimer() {
    _timer?.cancel();
    _isRunning = false;
    notifyListeners();
  }

  void resetTimer() {
    _timer?.cancel();
    _isRunning = false;
    _timeLeft = _workTime;
    _completedSessions = 0;
    _currentSession = 1;
    _isBreak = false;
    _isLongBreak = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}