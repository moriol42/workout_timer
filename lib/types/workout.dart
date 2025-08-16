import 'exercise.dart';

class Workout implements Iterator {
  Workout({
    required this.name,
    this.description,
    this.breakTime = const Duration(seconds: 30),
  });

  String name;
  String? description;
  Duration breakTime;
  final List<(Exercise, Duration)> _exercisesList = [];
  int _current = 0;
  bool _currentIsBreak = false;

  void add(Exercise e, Duration d) {
    _exercisesList.add((e, d));
  }

  @override
  (BaseExercise, Duration)? get current {
    if (_current < _exercisesList.length) {
      if (_currentIsBreak) {
        return (Break(), breakTime);
      } else {
        return _exercisesList[_current];
      }
    }
    return null;
  }

  @override
  bool moveNext() {
    if (_current < _exercisesList.length - 1) {
      if (_currentIsBreak) {
        _current++;
      }
      _currentIsBreak = !_currentIsBreak;
      return true;
    } else {
      _current = 0;
      return false;
    }
  }

  List<(Exercise, Duration)> get exercisesList {
    return _exercisesList;
  }
}
