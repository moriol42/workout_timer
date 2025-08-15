import 'package:flutter/material.dart';
import 'package:workout_timer/types/exercise.dart';

import '../back/back.dart';

class EditExercisePage extends StatefulWidget {
  const EditExercisePage({
    super.key,
    this.createNew = false,
    this.name,
    this.description,
  });

  final String? name;
  final String? description;
  final bool createNew;

  @override
  State<EditExercisePage> createState() => _EditExercisePageState();
}

class _EditExercisePageState extends State<EditExercisePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController controllerName; 
  late TextEditingController controllerDescr;

  @override
  void initState() {
    controllerName = TextEditingController(text : widget.name);
    controllerDescr = TextEditingController(text : widget.description);
    super.initState();
  }

  @override
  void dispose() {
    controllerName.dispose();
    controllerDescr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.createNew ? 'New Exercise' : 'Edit Exercise'),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                var descr = controllerDescr.text == '' ? null : controllerDescr.text;
                if (widget.createNew) {
                  exercises.add(Exercise(name: controllerName.text, description: descr));
                } else {
                  int i = exercises.indexWhere((e) => e.name == widget.name!);
                  exercises[i] = Exercise(name: controllerName.text, description: descr);
                }
                Navigator.pop(context, true);
              }
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Center(child: 
      Padding(
      padding: EdgeInsets.all(8.0),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.0,
                  children: <Widget>[
                    TextFormField(
                      controller: controllerName,
                      decoration: const InputDecoration(
                        hintText: 'Name of the exercise',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: controllerDescr,
                      decoration: const InputDecoration(
                        hintText: 'Description (optional)',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
        ],
      ),
    )),
    );
  }
}
