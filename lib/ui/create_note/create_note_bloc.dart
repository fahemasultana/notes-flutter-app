import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../data/entity/note_entity.dart';
import '../../main.dart';

part 'create_note_event.dart';

part 'create_note_state.dart';

class CreateNoteBloc extends Bloc<CreateNoteEvent, CreateNoteState> {
  NoteEntity? noteEntity;

  CreateNoteBloc(this.noteEntity) : super(CreateNoteInitial()) {
    on<InsertNoteEvent>((event, emit) async {
      DateTime now = DateTime.now();
      final timestamp = now.millisecondsSinceEpoch;
      if (noteEntity != null) {
        await appDatabase.notesDao.updateNote(NoteEntity(
          id: noteEntity!.id,
          title: event.title,
          description: event.description,
          date: timestamp,
        ));
      } else {
        await appDatabase.notesDao.insertNote(NoteEntity(
          title: event.title,
          description: event.description,
          date: timestamp,
        ));
      }

      emit(ClosePageState());
    });

    on<DeleteNoteEvent>((event, emit) async {
      await appDatabase.notesDao.deleteNote(noteEntity?.id ?? -1);
      emit(ClosePageState());
    });
  }
}
