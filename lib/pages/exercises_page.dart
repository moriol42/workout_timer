import 'package:flutter/material.dart';

import '../widgets/card_item.dart';
import 'edit_exercise_page.dart';
import '../back/back.dart';

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
                  deleteFn: () {
                    exercises.remove(e);
                    setState(() {});
                  },
                  onTap: () async {
                    bool? shouldRefresh = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute<bool>(
                        builder: (BuildContext context) {
                          return EditExercisePage(
                            createNew: false,
                            name: e.name,
                            description: e.description,
                          );
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
          bool? shouldRefresh = await Navigator.push<bool>(
            context,
            MaterialPageRoute<bool>(
              builder: (BuildContext context) {
                return EditExercisePage(createNew: true);
              },
            ),
          );
          if (shouldRefresh == true) {
            setState(() {});
          }
        },
        tooltip: 'New exercise',
        child: const Icon(Icons.add),
      ),
    );
  }
}
