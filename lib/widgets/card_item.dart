import 'package:flutter/material.dart';

class CardMenuEntry<T> {
  final T value;
  final Widget icon;
  final Widget title;

  const CardMenuEntry(this.value, this.icon, this.title);
}

class CardItem<T> extends StatefulWidget {
  const CardItem({
    super.key,
    required this.title,
    this.description,
    this.onTap,
    this.menuEntries = const [],
    this.onSelected,
  });

  final String title;
  final String? description;
  final Function()? onTap;
  final void Function(T)? onSelected;
  final List<CardMenuEntry<T>> menuEntries;

  @override
  State<CardItem<T>> createState() => _CardItemState();
}

class _CardItemState<T> extends State<CardItem<T>> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.title),
        subtitle: widget.description != null ? Text(widget.description!) : null,
        trailing: widget.menuEntries.isNotEmpty
            ? PopupMenuButton<T>(
                onSelected: widget.onSelected,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<T>>[
                  for (var e in widget.menuEntries)
                    PopupMenuItem<T>(
                      value: e.value,
                      child: ListTile(leading: e.icon, title: e.title),
                    ),
                ],
              )
            : null,
        onTap: widget.onTap,
      ),
    );
  }
}
