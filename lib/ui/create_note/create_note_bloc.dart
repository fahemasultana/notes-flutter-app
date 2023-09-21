import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:my_notes/data/repository/notes_repository.dart';

import '../../data/entity/note_entity.dart';
import '../../main.dart';

part 'create_note_event.dart';
part 'create_note_state.dart';

class CreateNoteBloc extends Bloc<CreateNoteEvent, CreateNoteState> {
  NotesRepository notesRepository = GetIt.I.get<NotesRepository>();
  NoteEntity? noteEntity;

  CreateNoteBloc(this.noteEntity) : super(CreateNoteInitial()) {
    on<InsertNoteEvent>((event, emit) async {
      await notesRepository.insertNote(
        noteEntity?.id,
        event.title,
        event.description,
      );
      emit(ClosePageState());
    });

    on<DeleteNoteEvent>((event, emit) async {
      await appDatabase.notesDao.deleteNote(noteEntity?.id ?? -1);
      emit(ClosePageState());
    });
  }
}
