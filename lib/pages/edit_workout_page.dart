import 'package:flutter/material.dart';
import 'package:workout_timer/types/exercise.dart';
import '../widgets/workout_exercise_card.dart';
import '../widgets/duration_picker.dart';
import '../types/workout.dart';

class EditWorkoutPage extends StatefulWidget {
  const EditWorkoutPage({super.key, required this.title, this.workout});

  final String title;
  final Workout? workout;

  @override
  State<EditWorkoutPage> createState() => _EditWorkoutPageState();
}

var exercise = Exercise(name: "pushups");

class _EditWorkoutPageState extends State<EditWorkoutPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Process data.
                Navigator.pop(context);
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
                          initialValue: widget.workout?.name,
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
                          initialValue: widget.workout?.description,
                          decoration: const InputDecoration(
                            hintText: 'Description (optional)',
                          ),
                        ),
                        DurationPicker(text: 'Break time:'),
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.workout != null)
                for (var (e, d) in widget.workout!.exercisesList)
                  WorkoutExerciseCard(exercise: e, duration: d),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Add Exercise'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
