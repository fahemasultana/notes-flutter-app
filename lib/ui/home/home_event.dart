import 'package:equatable/equatable.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class LoadNotesEvent extends HomeEvent {
  const LoadNotesEvent();
}

class DisableSelectModeEvent extends HomeEvent {
  const DisableSelectModeEvent();
}

class SelectNoteEvent extends HomeEvent {
  final int id;
  final bool selected;

  const SelectNoteEvent({required this.id, required this.selected});
}

class DeleteSelectedNotesEvent extends HomeEvent {
  const DeleteSelectedNotesEvent();
}


