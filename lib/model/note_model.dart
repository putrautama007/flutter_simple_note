import 'package:hive/hive.dart';
import 'package:simple_note/hive/hive_types.dart';
part 'note_model.g.dart';

@HiveType(typeId: HiveTypes.NOTE_MODEL)
class NoteModel extends HiveObject {
  @HiveField(1)
  String noteTitle;

  @HiveField(2)
  String noteBody;

  NoteModel({
    this.noteTitle,
    this.noteBody,
  });
}
