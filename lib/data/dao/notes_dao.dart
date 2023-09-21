import 'package:floor/floor.dart';

import '../entity/note_entity.dart';

@dao
abstract class NotesDao {
  @insert
  Future<int> insertNote(NoteEntity note);

  @update
  Future<int> updateNote(NoteEntity note);

  @Query('SELECT * FROM NoteEntity ORDER BY date DESC')
  Stream<List<NoteEntity>> findAllNotes();

  @Query('SELECT * FROM NoteEntity ORDER BY date DESC')
  Future<List<NoteEntity>> findAllNotesFuture();

  @Query('DELETE FROM NoteEntity WHERE id = :id')
  Future<int?> deleteNote(int id);

  @delete
  Future<int> deleteAll(List<NoteEntity> list);

  @Query('DELETE FROM NoteEntity')
  Future<int?> eraseAllNotes();

  @Query('DELETE * FROM NoteEntity WHERE id = :id')
  Future<int?> deleteSelectedNotes(int id);
}
