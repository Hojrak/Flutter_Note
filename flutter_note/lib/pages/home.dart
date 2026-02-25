import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/note.dart';
import 'package:test/models/note_db.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller to access the text field value
  final textControll = TextEditingController();

  @override
  void initState() {
    super.initState();
    readNote();
  }

  // create a note

  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create Note'),
        content: TextField(controller: textControll),
        actions: [
          // create button
          MaterialButton(
            onPressed: () {
              // add to database
              context.read<NoteDb>().createNote(textControll.text);

              //clear controller
              textControll.clear();

              // pop the dialog
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  // read a note

  void readNote() {
    context.read<NoteDb>().fetchNotes();
  }

  // update a note

  void updateNote(Note note) {
    textControll.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Note'),
        content: TextField(controller: textControll),
        actions: [
          // update button
          MaterialButton(
            onPressed: () {
              // update in database
              context.read<NoteDb>().updateNote(note.id, textControll.text);

              //clear controller
              textControll.clear();

              // pop the dialog
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  // delete a note

  void deleteNote(int id) {
    context.read<NoteDb>().deleteNote(id);
  }

  Widget build(BuildContext context) {
    // note database instance
    final noteDb = context.watch<NoteDb>();

    // current notes

    List<Note> currentNotes = NoteDb.currentNotes;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        title: const Text(
          'Flutter Note',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context, index) {
          // get the note at the current index
          final note = currentNotes[index];

          // list tile UI
          return ListTile(
            title: Text(note.text),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // edit button
                IconButton(
                  onPressed: () => updateNote(note),
                  icon: const Icon(Icons.edit),
                ),

                // delete button
                IconButton(
                  onPressed: () => deleteNote(note.id),
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
