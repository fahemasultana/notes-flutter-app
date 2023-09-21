import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../data/entity/note_entity.dart';
import '../../data/repository/notes_repository.dart';
import '../../main.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  NotesRepository notesRepository = GetIt.I.get<NotesRepository>();

  NoteEntity? noteEntity;

  HomeBloc() : super(HomeInitialState()) {
    on<LoadNotesEvent>((event, emit) async {
      emit(HomeLoadingState());

      final List<NoteEntity> notes = await notesRepository.findAllNotes();

      emit(HomeLoadedState(notes: notes));
    });

    on<DeleteSelectedNotesEvent>((event, emit) async {
      if (state is HomeLoadedState) {
        final currentState = state as HomeLoadedState;
        final selectedNotes = currentState.notes
            .where((element) => element.selected == true)
            .toList();

        await notesRepository.deleteAll(selectedNotes);
        final List<NoteEntity> notes = await notesRepository.findAllNotes();

        emit(HomeLoadingState());
        emit(HomeLoadedState(notes: notes, isSelecting: false));
      }
    });

    on<DisableSelectModeEvent>((event, emit) async {
      if (state is HomeLoadedState) {
        final currentState = state as HomeLoadedState;
        final notes = <NoteEntity>[];
        currentState.notes.forEach((element) {
          element.selected = false;
          notes.add(element);
        });
        emit(HomeLoadingState());
        emit(HomeLoadedState(notes: notes, isSelecting: false));
      }
    });

    on<SelectNoteEvent>((event, emit) async {
      if (state is HomeLoadedState) {
        final currentState = state as HomeLoadedState;

        final notes = <NoteEntity>[];
        int totalSelected = 0;
        currentState.notes.forEach((element) {
          if (element.id == event.id) {
            element.selected = event.selected;
          }
          if (element.selected) {
            totalSelected++;
          }
          notes.add(element);
        });

        emit(HomeLoadingState());
        emit(HomeLoadedState(
            notes: notes, isSelecting: true, totalSelected: totalSelected));
      }
    });
  }
}
