import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  const CardItem({super.key, required this.title, this.description, this.onTap});

  final String title;
  final String? description;
  final Function()? onTap;

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
        onTap: widget.onTap,
      ),
    );
  }
}
