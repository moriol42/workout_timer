import 'package:flutter/material.dart';

enum Actions { delete, edit }

class CardItem extends StatefulWidget {
  const CardItem({
    super.key,
    required this.title,
    this.description,
    this.onTap,
    this.deleteFn,
    this.editFn,
  });

  final String title;
  final String? description;
  final Function()? onTap;
  final Function()? deleteFn;
  final Function()? editFn;

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
        trailing: PopupMenuButton(
          onSelected: (Actions action) {
            setState(() {
              switch (action) {
                case Actions.delete:
                  widget.deleteFn!();
                  break;
                case Actions.edit:
                  widget.editFn!();
              }
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<Actions>>[
            if (widget.editFn != null)
              const PopupMenuItem<Actions>(
                value: Actions.edit,
                child: ListTile(leading: Icon(Icons.edit), title: Text('Edit')),
              ),
            const PopupMenuItem<Actions>(
              value: Actions.delete,
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text('Remove'),
              ),
            ),
          ],
        ),
        onTap: widget.onTap,
      ),
    );
  }
}
