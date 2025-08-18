import '../types/exercise.dart';
import '../types/workout.dart';

List<Exercise> _exercises = [
  Exercise(name: 'pushups'),
  Exercise(name: 'squat'),
];

List<Workout> _workouts = [
  Workout(name: 'test', breakTime: Duration(seconds: 5)),
];

void addExercise(Exercise e) {
  _exercises.add(e);
}

void editExercise(Exercise e, String newName, String? newDescription) {
  var i = _exercises.indexOf(e);
  _exercises[i].name = newName;
  _exercises[i].description = newDescription;
}

void removeExercise(Exercise e) {
  _exercises.remove(e);
}

Iterable<Exercise> iterExercises() sync* {
  for (var e in _exercises) {
    yield e;
  }
}

void addWorkout(Workout w) {
  _workouts.add(w);
}

void editWorkout(
  Workout w,
  String newName,
  String? newDescription,
  Duration newBreakTime,
  List<(Exercise, Duration)> newExercisesList,
) {
  var i = _workouts.indexOf(w);
  _workouts[i].name = newName;
  _workouts[i].description = newDescription;
  _workouts[i].breakTime = newBreakTime;
  _workouts[i].exercisesList = newExercisesList;
}

void removeWorkout(Workout w) {
  _workouts.remove(w);
}

Iterable<Workout> iterWorkouts() sync* {
  for (var w in _workouts) {
    yield w;
  }
}

void loadData() {}
