import 'package:flutter/material.dart';
import 'package:workout_timer/types/exercise.dart';

import '../widgets/card_item.dart';
import 'edit_exercise_page.dart';

List<Exercise> exercises = [Exercise(name: 'pushups'), Exercise(name: 'squat')];

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key, required this.title});

  final String title;

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              for (var e in exercises)
                CardItem(
                  title: e.name,
                  description: e.description,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return EditExercisePage(
                            title: 'Edit Exercise',
                            name: e.name,
                            description: e.description,
                          );
                        },
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return EditExercisePage(title: 'New exercise');
              },
            ),
          );
        },
        tooltip: 'New exercise',
        child: const Icon(Icons.add),
      ),
    );
  }
}
