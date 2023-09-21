// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:my_notes/data/dao/notes_dao.dart';
import 'package:my_notes/data/entity/note_entity.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [NoteEntity])
abstract class AppDatabase extends FloorDatabase {
  NotesDao get notesDao;
}
