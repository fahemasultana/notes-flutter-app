part of 'create_note_bloc.dart';

abstract class CreateNoteEvent {
  const CreateNoteEvent();
}

class InsertNoteEvent extends CreateNoteEvent {
  final String title, description;

  const InsertNoteEvent(this.title, this.description);
}

class DeleteNoteEvent extends CreateNoteEvent {
  const DeleteNoteEvent();
}
