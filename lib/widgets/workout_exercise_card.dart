import 'package:flutter/material.dart';
import './duration_picker.dart';

import '../types/exercise.dart';

class WorkoutExerciseCard extends StatefulWidget {
  const WorkoutExerciseCard({super.key, required this.exercise, this.duration = const Duration(seconds: 30)});

  final Exercise exercise;
  final Duration duration;

  @override
  State<WorkoutExerciseCard> createState() => _WorkoutExerciseCardState();
}

class _WorkoutExerciseCardState extends State<WorkoutExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 3,
          children: [
            Text(
              widget.exercise.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (widget.exercise.description != null)
              Text(widget.exercise.description!),
            DurationPicker(text: 'Duration', min: widget.duration.inMinutes, sec: widget.duration.inSeconds % 60),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_upward)),
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_downward)),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
