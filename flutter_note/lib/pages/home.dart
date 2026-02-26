import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test/components/drawer.dart';
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // heading
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Text(
              'Flutter Note',
              style: GoogleFonts.rockSalt(
                fontSize: 35,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          // lsit of notes
          Expanded(
            child: ListView.builder(
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
          ),
        ],
      ),
    );
  }
}
