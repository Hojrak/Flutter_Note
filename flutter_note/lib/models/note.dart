import 'package:isar/isar.dart';

// Run the command below to generate the note.g.dart file:
// dart run build_runner build

part 'note.g.dart';

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String text;

  // Store the Quill Delta content as JSON string for rich text
  String? contentJson;
}
