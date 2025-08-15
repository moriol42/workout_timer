import 'package:flutter/material.dart';
import 'package:workout_timer/types/exercise.dart';
import '../widgets/workout_exercise_card.dart';

class EditWorkoutPage extends StatefulWidget {
  const EditWorkoutPage({
    super.key,
    required this.title,
    this.name,
    this.description,
  });

  final String title;
  final String? name;
  final String? description;

  @override
  State<EditWorkoutPage> createState() => _EditWorkoutPageState();
}

var exercise = Exercise(name: "pushups");

class _EditWorkoutPageState extends State<EditWorkoutPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
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
                          initialValue: widget.name,
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
                          initialValue: widget.description,
                          decoration: const InputDecoration(
                            hintText: 'Description (optional)',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              WorkoutExerciseCard(exercise: exercise),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  spacing: 10.0,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromRGBO(255, 205, 210, 1),
                        ),
                        foregroundColor: WidgetStateProperty.all<Color>(
                          Colors.red,
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Process data.
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
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
