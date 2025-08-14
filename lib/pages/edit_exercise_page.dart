import 'package:flutter/material.dart';
import '../widgets/exercise_form.dart';

class EditExercisePage extends StatefulWidget {
  const EditExercisePage({
    super.key,
    required this.title,
    this.name,
    this.description,
  });

  final String title;
  final String? name;
  final String? description;

  @override
  State<EditExercisePage> createState() => _EditExercisePageState();
}

class _EditExercisePageState extends State<EditExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: ExerciseForm(name: widget.name, description: widget.description),
      ),
    );
  }
}
