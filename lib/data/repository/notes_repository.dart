import 'package:my_notes/data/entity/note_entity.dart';

import '../../main.dart';

class NotesRepository {
  insertNote(int? id, String title, String description) async {
    DateTime now = DateTime.now();
    final timestamp = now.millisecondsSinceEpoch;

    final entity = NoteEntity(
      id: id,
      title: title,
      description: description,
      date: timestamp,
    );

    if (id != null) {
      return appDatabase.notesDao.updateNote(entity);
    } else {
      return appDatabase.notesDao.insertNote(entity);
    }
  }

  updateNote(NoteEntity entity) async {
    return appDatabase.notesDao.updateNote(entity);
  }

  deleteNote(int id) async {
    return appDatabase.notesDao.deleteNote(id);
  }

  deleteAll(List<NoteEntity> list) async {
    return appDatabase.notesDao.deleteAll(list);
  }

  findAllNotes() async {
    return appDatabase.notesDao.findAllNotesFuture();
  }
}
