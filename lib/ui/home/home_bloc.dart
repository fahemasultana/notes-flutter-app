import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/note_entity.dart';
import '../../main.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  NoteEntity? noteEntity;

  HomeBloc() : super(HomeInitialState()) {
    on<LoadNotesEvent>((event, emit) async {
      emit(HomeLoadingState());

      final List<NoteEntity> notes =
          await appDatabase.notesDao.findAllNotesFuture();

      emit(HomeLoadedState(notes: notes));
    });

    on<DeleteSelectedNotesEvent>((event, emit) async {
      if (state is HomeLoadedState) {
        final currentState = state as HomeLoadedState;
        final selectedNotes = currentState.notes
            .where((element) => element.selected == true)
            .toList();

        await appDatabase.notesDao.deleteAll(selectedNotes);
        final List<NoteEntity> notes =
            await appDatabase.notesDao.findAllNotesFuture();

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
