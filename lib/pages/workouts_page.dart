import 'package:flutter/material.dart';

import 'edit_workout_page.dart';
import 'timer_page.dart';
import '../widgets/card_item.dart';

import '../back/back.dart';

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
                  deleteFn: () {
                    removeWorkout(w);
                    setState(() {});
                  },
                  editFn: () async {
                    bool? shouldRefresh = await Navigator.push(
                      context,
                      MaterialPageRoute<bool>(
                        builder: (BuildContext context) {
                          return EditWorkoutPage(createNew: false, workout: w);
                        },
                      ),
                    );
                    if (shouldRefresh == true) {
                      setState(() {});
                    }
                  },
                ),
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
