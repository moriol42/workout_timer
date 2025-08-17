import 'exercise.dart';

class Workout implements Iterator {
  Workout({
    required this.name,
    this.description,
    this.breakTime = const Duration(seconds: 30),
    List<(Exercise, Duration)>? exercisesList,
  }) : _exercisesList = exercisesList ?? [];

  String name;
  String? description;
  Duration breakTime;
  final List<(Exercise, Duration)> _exercisesList;
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

  (BaseExercise, Duration)? get next {
    if (_current < _exercisesList.length - 1) {
      if (_currentIsBreak) {
        return _exercisesList[_current + 1];
      } else {
        return (Break(), breakTime);
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
      return false;
    }
  }

  List<(Exercise, Duration)> get exercisesList {
    return _exercisesList;
  }

  void resetIterator() {
    _currentIsBreak = false;
    _current = 0;
  }
}
