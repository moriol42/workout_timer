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
    return Dialog(
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!,
        child: UnconstrainedBox(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Choose exercises to add',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(
                  width: 200,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 5.0,
                    ),
                    shrinkWrap: true,
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
            ),
          ),
        ),
      ),
    );
  }
}
