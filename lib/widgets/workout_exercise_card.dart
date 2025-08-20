import 'package:flutter/material.dart';
import './duration_picker.dart';

import '../types/exercise.dart';

class WorkoutExerciseCard extends StatefulWidget {
  const WorkoutExerciseCard({
    super.key,
    required this.exercise,
    this.controller,
    this.onRemove,
  });

  final WorkoutExerciseController? controller;
  final Exercise exercise;
  final void Function()? onRemove;

  @override
  State<WorkoutExerciseCard> createState() => _WorkoutExerciseCardState();
}

class _WorkoutExerciseCardState extends State<WorkoutExerciseCard> {
  late DurationPickerController controllerTime;
  late Exercise _exercise;
  bool _expanded = false;

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
    if (_expanded) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 3,
            children: [
              Row(
                children: [
                  Text(
                    _exercise.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                    icon: Icon(Icons.expand_less),
                  ),
                ],
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
                  FilledButton.tonalIcon(
                    onPressed: widget.onRemove,
                    label: Text('Delete'),
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Card(
        child: ListTile(
          title: Text(
            _exercise.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${controllerTime.duration.inMinutes}:${controllerTime.duration.inSeconds % 60}',
          ),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            icon: Icon(Icons.expand_more),
          ),
        ),
      );
    }
  }
}

class WorkoutExerciseController {
  WorkoutExerciseController({this.duration = const Duration(seconds: 30)});

  Duration duration;
  late Exercise exercise;
}
