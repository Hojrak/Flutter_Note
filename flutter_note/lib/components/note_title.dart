import 'package:flutter/material.dart';
import 'package:flutter_note/models/note.dart';

enum NoteAction { edit, delete }

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
        trailing: PopupMenuButton<NoteAction>(
          icon: const Icon(Icons.more_vert),
          onSelected: (NoteAction action) {
            if (action == NoteAction.edit) {
              onEditPressed?.call();
            } else if (action == NoteAction.delete) {
              onDeletePressed?.call();
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: NoteAction.edit,
              child: Row(
                children: [Icon(Icons.edit), SizedBox(width: 8), Text('Edit')],
              ),
            ),
            const PopupMenuItem(
              value: NoteAction.delete,
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Delete', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
