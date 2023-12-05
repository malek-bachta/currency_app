import 'package:flutter/material.dart';

class DeleteConfirmation extends StatelessWidget {
  final VoidCallback onConfirmDelete;

  const DeleteConfirmation({
    Key? key,
    required this.onConfirmDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirm Delete"),
      content: Text("Are you sure you want to delete this conversion?"),
      actions: <Widget>[
        TextButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text("Delete", style: TextStyle(color: Colors.red)),
          onPressed: () {
            onConfirmDelete();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
