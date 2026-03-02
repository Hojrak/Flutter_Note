import 'package:flutter/material.dart';
import 'package:test/models/note.dart';

class NoteTitle extends StatelessWidget {
  final String text;
  final Note note;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  final void Function()? onTitleTap;

  const NoteTitle({
    super.key,
    required this.text,
    required this.note,
    this.onEditPressed,
    this.onDeletePressed,
    this.onTitleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: GestureDetector(
          onTap: onTitleTap,
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // edit button
            IconButton(onPressed: onEditPressed, icon: const Icon(Icons.edit)),

            // delete button
            IconButton(
              onPressed: onDeletePressed,
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
