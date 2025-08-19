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
  late TextEditingController controllerRepet;
  late DurationPickerController controllerBreakTime;
  final List<WorkoutExerciseController> _controllersExerciseCards = [];
  List<WorkoutExerciseCard> _exercisesCards = [];
  bool isChecked = false;
  bool _expanded = true;

  @override
  void initState() {
    controllerName = TextEditingController(text: widget.workout?.name);
    controllerDescr = TextEditingController(text: widget.workout?.description);
    controllerBreakTime = DurationPickerController(
      duration: widget.workout?.breakTime ?? const Duration(seconds: 30),
    );
    controllerRepet = TextEditingController(
      text: '${widget.workout?.repetitions ?? 1}',
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
                var newExercisesList = _controllersExerciseCards
                    .map((c) => (c.exercise, c.duration))
                    .toList();
                if (widget.createNew) {
                  var newWorkout = Workout(
                    name: controllerName.text,
                    description: descr,
                    breakTime: controllerBreakTime.duration,
                    exercisesList: newExercisesList,
                    repetitions: int.parse(controllerRepet.text),
                  );
                  addWorkout(newWorkout);
                } else {
                  editWorkout(
                    widget.workout!,
                    controllerName.text,
                    descr,
                    controllerBreakTime.duration,
                    newExercisesList,
                    int.parse(controllerRepet.text),
                  );
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
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 8.0,
                      children: <Widget>[
                        TextFormField(
                          controller: controllerName,
                          decoration: const InputDecoration(labelText: 'Name'),
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
                            labelText: 'Description (optional)',
                          ),
                        ),

                        if (_expanded)
                          DurationPicker(
                            text: 'Break time:',
                            controller: controllerBreakTime,
                          ),

                        if (_expanded)
                          TextFormField(
                            controller: controllerRepet,
                            decoration: const InputDecoration(
                              labelText: 'Number of repetitions',

                              suffixText: 'repetitions',
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some number';
                              }
                              if (int.tryParse(value) == null) {
                                return 'You must enter a number';
                              }
                              return null;
                            },
                          ),

                        SizedBox(height: 10),
                        FilledButton.tonal(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _expanded
                                ? [
                                    Text('Less'),
                                    SizedBox(width: 5),
                                    Icon(Icons.expand_less),
                                  ]
                                : [
                                    Text('More'),
                                    SizedBox(width: 5),
                                    Icon(Icons.expand_more),
                                  ],
                          ),
                          onPressed: () {
                            setState(() {
                              _expanded = !_expanded;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              for (var c in _exercisesCards) c,
              SizedBox(height: 60),
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
                    ExerciseChooser(),
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
