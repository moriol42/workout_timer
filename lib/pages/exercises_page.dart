import 'package:flutter/material.dart';

import '../widgets/card_item.dart';
import 'new_exercise_page.dart';

List<String> exercises = <String>['Push-ups', 'Squats', 'Jumping jack'];

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
            children: <Widget>[for (var e in exercises) CardItem(title: e)],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return NewExercisePage();
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
