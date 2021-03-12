part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();
}

class InitialState extends NoteState {
  @override
  List<Object> get props => [];
}

class LoadingState extends NoteState {
  @override
  List<Object> get props => [];
}

class LoadSuccessState extends NoteState {
  final List<NoteModel> noteList;

  LoadSuccessState({
    @required this.noteList,
  });

  @override
  List<Object> get props => [noteList];
}

class LoadEmptyDataState extends NoteState {
  @override
  List<Object> get props => [];
}

class LoadFailedState extends NoteState {
  @override
  List<Object> get props => [];
}

class SaveSuccessState extends NoteState {
  @override
  List<Object> get props => [];
}

class SaveFailedState extends NoteState {
  @override
  List<Object> get props => [];
}

class DeleteSuccessState extends NoteState {
  @override
  List<Object> get props => [];
}

class DeleteFailedState extends NoteState {
  @override
  List<Object> get props => [];
}
