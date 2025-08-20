import 'dart:convert';

import '../types/exercise.dart';
import '../types/workout.dart';

import 'data_storage.dart';

List<Exercise> _exercises = [];

List<Workout> _workouts = [];

DataStorage _dataStorage = DataStorage();

void addExercise(Exercise e) {
  _exercises.removeWhere((e2) => e.name == e2.name);
  _exercises.add(e);
  storeExercise();
}

void editExercise(Exercise e, String newName, String? newDescription) {
  var i = _exercises.indexOf(e);
  _exercises[i].name = newName;
  _exercises[i].description = newDescription;
  storeExercise();
}

void removeExercise(Exercise e) {
  _exercises.remove(e);
  for (var w in _workouts) {
    w.exercisesList.removeWhere((x) => x.$1 == e);
  }
  storeExercise();
  storeWorkout();
}

Iterable<Exercise> iterExercises() sync* {
  for (var e in _exercises) {
    yield e;
  }
}

void addWorkout(Workout w) {
  _workouts.removeWhere((w2) => w.name == w2.name);
  _workouts.add(w);
  storeWorkout();
}

void editWorkout(
  Workout w,
  String newName,
  String? newDescription,
  Duration newBreakTime,
  List<(Exercise, Duration)> newExercisesList,
  int repetitions,
  Duration interRepetitionBreak,
) {
  var i = _workouts.indexOf(w);
  _workouts[i].name = newName;
  _workouts[i].description = newDescription;
  _workouts[i].breakTime = newBreakTime;
  _workouts[i].exercisesList = newExercisesList;
  _workouts[i].repetitions = repetitions;
  _workouts[i].interRepetitionBreak = interRepetitionBreak;
  storeWorkout();
}

void removeWorkout(Workout w) {
  _workouts.remove(w);
  storeWorkout();
}

Iterable<Workout> iterWorkouts() sync* {
  for (var w in _workouts) {
    yield w;
  }
}

Future<()> loadData() async {
  try {
    var exercisesJson = await _dataStorage.readData('exercises.json');
    var exercisesMap = jsonDecode(exercisesJson);
    for (var eJson in exercisesMap) {
      _exercises.add(Exercise.fromJson(eJson));
    }
  } catch (e) {}

  try {
    var workoutsJson = await _dataStorage.readData('workouts.json');
    var workoutsMap = jsonDecode(workoutsJson);
    for (var wJson in workoutsMap) {
      _workouts.add(Workout.fromJson(wJson, iterExercises()));
    }
  } catch (e) {}
  return ();
}

void storeExercise() async {
  var exercisesJson = jsonEncode(_exercises);
  _dataStorage.writeData('exercises.json', exercisesJson);
}

void storeWorkout() async {
  var workoutsJson = jsonEncode(_workouts);
  _dataStorage.writeData('workouts.json', workoutsJson);
}
