import 'package:flutter/material.dart';

import 'edit_workout_page.dart';
import 'timer_page.dart';
import '../widgets/card_item.dart';

import '../back/back.dart';
import '../types/workout.dart';

enum WorkoutCardActions { delete, edit, duplicate }

class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({super.key, required this.title});

  final String title;

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              for (var w in iterWorkouts())
                CardItem(
                  title: w.name,
                  description: w.description,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return TimerPage(workout: w);
                        },
                      ),
                    );
                  },
                  menuEntries: [
                    CardMenuEntry(
                      WorkoutCardActions.edit,
                      Icon(Icons.edit),
                      Text('Edit'),
                    ),
                    CardMenuEntry(
                      WorkoutCardActions.duplicate,
                      Icon(Icons.copy),
                      Text('Duplicate'),
                    ),
                    CardMenuEntry(
                      WorkoutCardActions.delete,
                      Icon(Icons.delete),
                      Text('Delete'),
                    ),
                  ],
                  onSelected: (WorkoutCardActions action) async {
                    switch (action) {
                      case WorkoutCardActions.delete:
                        setState(() {
                          removeWorkout(w);
                        });
                        break;
                      case WorkoutCardActions.edit:
                        {
                          bool? shouldRefresh = await Navigator.push(
                            context,
                            MaterialPageRoute<bool>(
                              builder: (BuildContext context) {
                                return EditWorkoutPage(
                                  createNew: false,
                                  workout: w,
                                );
                              },
                            ),
                          );
                          if (shouldRefresh == true) {
                            setState(() {});
                          }
                          break;
                        }
                      case WorkoutCardActions.duplicate:
                        var newWorkout = Workout(
                          name: '${w.name} copy',
                          description: w.description,
                          breakTime: w.breakTime,
                          exercisesList: List.from(w.exercisesList),
                          repetitions: w.repetitions,
                          interRepetitionBreak: w.interRepetitionBreak,
                        );
                        setState(() {
                          addWorkout(newWorkout);
                        });
                        break;
                    }
                  },
                ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? shouldRefresh = await Navigator.push(
            context,
            MaterialPageRoute<bool>(
              builder: (BuildContext context) {
                return EditWorkoutPage(createNew: true);
              },
            ),
          );
          if (shouldRefresh == true) {
            setState(() {});
          }
        },
        tooltip: 'New workout',
        child: const Icon(Icons.add),
      ),
    );
  }
}
