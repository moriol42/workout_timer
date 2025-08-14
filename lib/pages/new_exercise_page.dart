import 'package:flutter/material.dart';
import '../widgets/exercise_form.dart';

class NewExercisePage extends StatefulWidget {
  const NewExercisePage({super.key});

  @override
  State<NewExercisePage> createState() => _NewExercisePageState();
}

class _NewExercisePageState extends State<NewExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Exercise')),
      body: const Center(
        child: ExerciseForm(),
      ),
    );
  }
}
