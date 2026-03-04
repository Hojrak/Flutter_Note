import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_note/models/note.dart';
import 'package:flutter_note/models/note_db.dart';

class PlainTextEditorPage extends StatefulWidget {
  final Note note;

  const PlainTextEditorPage({super.key, required this.note});

  @override
  State<PlainTextEditorPage> createState() => _PlainTextEditorPageState();
}

class _PlainTextEditorPageState extends State<PlainTextEditorPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.note.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_controller.text.isNotEmpty) {
      context.read<NoteDb>().updateNote(widget.note.id, _controller.text);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Edit Note (Plain Text)'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveNote),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _controller,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: 16,
            ),
            decoration: const InputDecoration(
              hintText: 'Enter note text...',
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
