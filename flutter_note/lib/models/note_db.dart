import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'note.dart';

class NoteDb extends ChangeNotifier {
  static late Isar isar;

  //INITIALIZE - DATABASE

  static Future<void> init() async {
    final dir = await getApplicationSupportDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  //LIST OF NOTES

  static List<Note> currentNotes = [];

  //CREATE - note and save to database

  Future<void> createNote(String textFromUser) async {
    // Create a new note
    final newNote = Note()..text = textFromUser;

    // Save the note to the database

    await isar.writeTxn(() => isar.notes.put(newNote));

    fetchNotes();
  }

  //READ - all notes from database

  Future<void> fetchNotes() async {
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    notifyListeners();
  }

  //UPDATE - note in database

  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  //DELETE - note from database

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
