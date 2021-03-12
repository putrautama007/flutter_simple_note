import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:simple_note/hive/hive_boxs.dart';
import 'package:simple_note/model/note_model.dart';

abstract class HiveService {
  Future<bool> addNote({NoteModel note});

  Future<List<NoteModel>> getListNote();

  Future<bool> updateNote({int index, NoteModel note});

  Future<bool> deleteNote({int index});
}

class HiveServiceImpl extends HiveService {
  final HiveInterface hive;

  HiveServiceImpl({@required this.hive});

  @override
  Future<bool> addNote({NoteModel note}) async {
    try {
      final _noteBox = await hive.openBox<NoteModel>(HiveBoxs.NOTE_BOX);
      _noteBox.add(note);
      await _noteBox.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteNote({int index}) async {
    try {
      final _noteBox = await hive.openBox<NoteModel>(HiveBoxs.NOTE_BOX);
      _noteBox.deleteAt(index);
      await _noteBox.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<NoteModel>> getListNote() async {
    try {
      final _noteBox = await hive.openBox<NoteModel>(HiveBoxs.NOTE_BOX);
      return _noteBox.values.toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> updateNote({int index, NoteModel note}) async {
    try {
      final _noteBox = await hive.openBox<NoteModel>(HiveBoxs.NOTE_BOX);
      _noteBox.putAt(index, note);
      await _noteBox.close();
      return true;
    } catch (e) {
      return false;
    }
  }
}
