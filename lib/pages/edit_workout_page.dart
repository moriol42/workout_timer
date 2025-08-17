import 'package:flutter/material.dart';
import 'package:workout_timer/types/exercise.dart';
import '../widgets/workout_exercise_card.dart';
import '../widgets/duration_picker.dart';
import '../widgets/exercise_chooser.dart';
import '../types/workout.dart';

import '../back/back.dart';

class EditWorkoutPage extends StatefulWidget {
  const EditWorkoutPage({super.key, this.createNew = false, this.workout});

  final Workout? workout;
  final bool createNew;

  @override
  State<EditWorkoutPage> createState() => _EditWorkoutPageState();
}

class _EditWorkoutPageState extends State<EditWorkoutPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController controllerName;
  late TextEditingController controllerDescr;
  late DurationPickerController controllerBreakTime;
  final List<WorkoutExerciseController> _controllersExerciseCards = [];
  List<WorkoutExerciseCard> _exercisesCards = [];
  bool isChecked = false;

  @override
  void initState() {
    controllerName = TextEditingController(text: widget.workout?.name);
    controllerDescr = TextEditingController(text: widget.workout?.description);
    controllerBreakTime = DurationPickerController(
      duration: widget.workout?.breakTime ?? const Duration(seconds: 30),
    );

    if (!widget.createNew) {
      _exercisesCards = widget.workout!.exercisesList.map((tuple) {
        var controller = WorkoutExerciseController(duration: tuple.$2);
        _controllersExerciseCards.add(controller);
        return WorkoutExerciseCard(exercise: tuple.$1, controller: controller);
      }).toList();
    }

    super.initState();
  }

  @override
  void dispose() {
    controllerName.dispose();
    controllerDescr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.createNew ? 'New Workout' : 'Edit Workout'),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                var descr = controllerDescr.text == ''
                    ? null
                    : controllerDescr.text;
                var newWorkout = Workout(
                  name: controllerName.text,
                  description: descr,
                  breakTime: controllerBreakTime.duration,
                  exercisesList: _controllersExerciseCards
                      .map((c) => (c.exercise, c.duration))
                      .toList(),
                );
                debugPrint(
                  'newWorkout : ${newWorkout.toString()}, name : ${newWorkout.name}',
                );
                if (widget.createNew) {
                  workouts.add(newWorkout);
                } else {
                  int i = workouts.indexWhere((w) => w == widget.workout!);
                  workouts[i] = newWorkout;
                }
                Navigator.pop(context, true);
              }
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8.0,
                      children: <Widget>[
                        TextFormField(
                          controller: controllerName,
                          decoration: const InputDecoration(
                            hintText: 'Name of the exercise',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: controllerDescr,
                          decoration: const InputDecoration(
                            hintText: 'Description (optional)',
                          ),
                        ),
                        DurationPicker(
                          text: 'Break time:',
                          controller: controllerBreakTime,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              for (var c in _exercisesCards) c,
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          List<Exercise>? exercisesList = await showDialog(
            context: context,
            builder: (_) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter myState) =>
                    ExerciseChooser()
              );
            },
          );

          if (exercisesList?.isNotEmpty ?? false) {
            for (var e in exercisesList!) {
              var c = WorkoutExerciseController();
              _exercisesCards.add(
                WorkoutExerciseCard(exercise: e, controller: c),
              );
              _controllersExerciseCards.add(c);
            }
            setState(() {});
          }
        },
        label: const Text('Add Exercise'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
