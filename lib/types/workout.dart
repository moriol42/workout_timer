import 'exercise.dart';

class Workout implements Iterator {
  String name;
  String? description;
  Duration breakTime;
  List<(Exercise, Duration)> exercisesList;
  int _current = 0;
  bool _currentIsBreak = false;

  Workout({
    required this.name,
    this.description,
    this.breakTime = const Duration(seconds: 30),
    List<(Exercise, Duration)>? exercisesList,
  }) : exercisesList = exercisesList ?? [];

  Workout.fromJson(Map<String, dynamic> json, List<Exercise> listExercises)
    : name = json['name'] as String,
      breakTime = Duration(seconds: json['breakTime'] as int),
      exercisesList = [] {
    description = json['description'] as String;
    if (description == '') {
      description = null;
    }

    for (var e in json['exercisesList']) {
      var exName = e[0];
      var seconds = e[1] as int;
      exercisesList.add((
        listExercises.where((e) => e.name == exName).first,
        Duration(seconds: seconds),
      ));
    }
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description ?? '',
    'breakTime': breakTime.inSeconds,
    'exercisesList': [
      for (var e in exercisesList) [e.$1.name, e.$2.inSeconds],
    ],
  };

  void add(Exercise e, Duration d) {
    exercisesList.add((e, d));
  }

  @override
  (BaseExercise, Duration)? get current {
    if (_current < exercisesList.length) {
      if (_currentIsBreak) {
        return (Break(), breakTime);
      } else {
        return exercisesList[_current];
      }
    }
    return null;
  }

  (BaseExercise, Duration)? get next {
    if (_current < exercisesList.length - 1) {
      if (_currentIsBreak) {
        return exercisesList[_current + 1];
      } else {
        return (Break(), breakTime);
      }
    }
    return null;
  }

  @override
  bool moveNext() {
    if (_current < exercisesList.length - 1) {
      if (_currentIsBreak) {
        _current++;
      }
      _currentIsBreak = !_currentIsBreak;
      return true;
    } else {
      return false;
    }
  }

  void resetIterator() {
    _currentIsBreak = false;
    _current = 0;
  }
}
