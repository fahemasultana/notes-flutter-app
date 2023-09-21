import 'package:equatable/equatable.dart';
import 'package:my_notes/data/entity/note_entity.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeEmptyState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<NoteEntity> notes;
  final bool isSelecting;
  final int totalSelected;

  const HomeLoadedState({
    required this.notes,
    this.isSelecting = false,
    this.totalSelected = 0,
  });

  @override
  List<Object> get props => [notes, isSelecting, totalSelected];
}
