import 'package:flutter/material.dart';
import './duration_picker.dart';

import '../types/exercise.dart';

class WorkoutExerciseCard extends StatefulWidget {
  const WorkoutExerciseCard({
    super.key,
    required this.exercise,
    this.controller,
  });

  final WorkoutExerciseController? controller;
  final Exercise exercise;

  @override
  State<WorkoutExerciseCard> createState() => _WorkoutExerciseCardState();
}

class _WorkoutExerciseCardState extends State<WorkoutExerciseCard> {
  late DurationPickerController controllerTime;
  late Exercise _exercise;

  @override
  void initState() {
    controllerTime = DurationPickerController(
      duration: widget.controller?.duration ?? Duration(seconds: 30),
    );
    _exercise = widget.exercise;
    widget.controller?.exercise = widget.exercise;

    super.initState();
  }

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
              _exercise.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (_exercise.description != null) Text(_exercise.description!),
            DurationPicker(
              text: 'Duration',
              controller: controllerTime,
              onChanged: () {
                widget.controller?.duration = controllerTime.duration;
              },
            ),

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

class WorkoutExerciseController {
  WorkoutExerciseController({this.duration = const Duration(seconds: 30)});

  Duration duration;
  late Exercise exercise;
}
