part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();
}

class CreateNote extends NoteEvent {
  final NoteModel noteModel;

  CreateNote({
    @required this.noteModel,
  });

  @override
  List<Object> get props => [
        noteModel,
      ];
}

class GetNoteList extends NoteEvent {
  @override
  List<Object> get props => [];
}

class UpdateNote extends NoteEvent {
  final NoteModel noteModel;
  final int noteIndex;

  UpdateNote({
    @required this.noteModel,
    @required this.noteIndex,
  });

  @override
  List<Object> get props => [
        noteModel,
        noteIndex,
      ];
}

class DeleteNote extends NoteEvent {
  final int noteIndex;

  DeleteNote({
    @required this.noteIndex,
  });

  @override
  List<Object> get props => [
        noteIndex,
      ];
}
