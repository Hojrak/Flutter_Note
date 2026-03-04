import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_note/models/note.dart';
import 'package:flutter_note/models/note_db.dart';

class NoteDetailPage extends StatefulWidget {
  final Note note;

  const NoteDetailPage({super.key, required this.note});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late QuillController _quillController;
  late TextEditingController _plainTextController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _plainTextController = TextEditingController(text: widget.note.text);

    // Initialize Quill controller with existing content or empty document
    if (widget.note.contentJson != null &&
        widget.note.contentJson!.isNotEmpty) {
      try {
        final json = jsonDecode(widget.note.contentJson!);
        _quillController = QuillController(
          document: Document.fromJson(json),
          selection: const TextSelection.collapsed(offset: 0),
        );
      } catch (e) {
        // If parsing fails, create a new document with the plain text
        _quillController = QuillController(
          document: Document()..insert(0, widget.note.text),
          selection: const TextSelection.collapsed(offset: 0),
        );
      }
    } else {
      _quillController = QuillController(
        document: Document()..insert(0, widget.note.text),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
  }

  @override
  void dispose() {
    _quillController.dispose();
    _plainTextController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _saveNote() {
    // Get plain text for display in list
    final plainText = _quillController.document.toPlainText();
    // Get Delta JSON for rich text storage
    final contentJson = jsonEncode(
      _quillController.document.toDelta().toJson(),
    );

    if (plainText.isNotEmpty) {
      context.read<NoteDb>().updateNoteWithContent(
        widget.note.id,
        plainText,
        contentJson,
      );
      Navigator.pop(context);
    }
  }

  void _deleteNote() {
    context.read<NoteDb>().deleteNote(widget.note.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(icon: const Icon(Icons.delete), onPressed: _deleteNote),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Quill Toolbar for text formatting options
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: QuillSimpleToolbar(
                  controller: _quillController,
                  config: const QuillSimpleToolbarConfig(
                    showAlignmentButtons: true,
                    showBackgroundColorButton: false,
                    showClearFormat: true,
                    showCodeBlock: false,
                    showColorButton: true,
                    showDirection: false,
                    showFontFamily: false,
                    showFontSize: false,
                    showHeaderStyle: true,
                    showIndent: true,
                    showInlineCode: false,
                    showLink: true,
                    showListBullets: true,
                    showListNumbers: true,
                    showListCheck: true,
                    showQuote: true,
                    showSearchButton: false,
                    showStrikeThrough: true,
                    showSubscript: false,
                    showSuperscript: false,
                    showUndo: true,
                    showRedo: true,
                    multiRowsDisplay: false,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Quill Editor for rich text editing
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: QuillEditor(
                    controller: _quillController,
                    focusNode: _focusNode,
                    scrollController: ScrollController(),
                    config: QuillEditorConfig(
                      placeholder: 'Enter note text...',
                      padding: const EdgeInsets.all(12),
                      expands: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveNote,
                child: const Text('Save Note'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
