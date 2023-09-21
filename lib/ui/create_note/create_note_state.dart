part of 'create_note_bloc.dart';

abstract class CreateNoteState extends Equatable {
  const CreateNoteState();

  @override
  List<Object> get props => [];
}

class CreateNoteInitial extends CreateNoteState {}


class ClosePageState extends CreateNoteState {}