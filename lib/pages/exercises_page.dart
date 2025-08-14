import 'package:flutter/material.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key, required this.title});

  final String title;

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  void _incrementCounter() {
    setState(() {
    });
  }

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
              Card(
                child: ListTile(
                  title: Text('Push-ups'),
                  trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Squats'),
                  trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'New exercise',
        child: const Icon(Icons.add),
      ),
    );
  }
}