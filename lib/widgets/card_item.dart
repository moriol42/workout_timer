import 'package:flutter/material.dart';

import '../pages/edit_exercise_page.dart';

class CardItem extends StatefulWidget {
  const CardItem({super.key, required this.title, this.description});

  final String title;
  final String? description;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.title),
        subtitle: widget.description != null ? Text(widget.description!) : null,
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return EditExercisePage(
                  title: 'Edit Exercise',
                  name: widget.title,
                  description: widget.description,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
