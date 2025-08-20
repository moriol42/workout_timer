import 'package:flutter/material.dart';

import '../back/back.dart';

class ExerciseChooser extends StatefulWidget {
  const ExerciseChooser({super.key});

  @override
  State<ExerciseChooser> createState() => _ExerciseChooserState();
}

class _ExerciseChooserState extends State<ExerciseChooser> {
  List<bool> isChecked = [for (var _ in iterExercises()) false];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Choose exercises to add',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      contentPadding: const EdgeInsets.all(16.0),
      content: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              for (var (i, e) in iterExercises().indexed)
                Row(
                  children: [
                    Checkbox(
                      value: isChecked[i],
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked[i] = value!;
                        });
                      },
                    ),
                    Text(
                      e.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(
              context,
              iterExercises().indexed
                  .where((x) => isChecked[x.$1])
                  .map((x) => x.$2)
                  .toList(),
            );
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
