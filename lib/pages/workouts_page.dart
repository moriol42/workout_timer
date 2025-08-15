import 'package:flutter/material.dart';

import 'edit_workout_page.dart';
import '../widgets/card_item.dart';

List<String> workouts = <String>['Day 1', 'Day 2'];

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
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              for (var w in workouts)
                CardItem(
                  title: w,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return EditWorkoutPage(
                            title: 'Edit workout',
                            name: w,
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
                return EditWorkoutPage(title: 'New workout');
              },
            ),
          );
        },
        tooltip: 'New workout',
        child: const Icon(Icons.add),
      ),
    );
  }
}
