import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_note/hive/hive_service.dart';
import 'package:simple_note/model/note_model.dart';

part 'note_event.dart';

part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final HiveService hiveService;

  NoteBloc({
    @required this.hiveService,
  }) : super(InitialState());

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is CreateNote) {
      try {
        yield LoadingState();
        bool _isCreated = await hiveService.addNote(note: event.noteModel);
        if (_isCreated) {
          yield SaveSuccessState();
        } else {
          yield SaveFailedState();
        }
      } catch (e) {
        yield SaveFailedState();
      }
    } else if (event is GetNoteList) {
      try {
        yield LoadingState();
        List<NoteModel> _listNote = await hiveService.getListNote();
        if (_listNote != null) {
          yield LoadSuccessState(noteList: _listNote);
        } else {
          yield LoadEmptyDataState();
        }
      } catch (e) {
        yield LoadFailedState();
      }
    } else if (event is UpdateNote) {
      try {
        yield LoadingState();
        bool _isUpdated = await hiveService.updateNote(
            index: event.noteIndex, note: event.noteModel);
        if (_isUpdated) {
          yield SaveSuccessState();
        } else {
          yield SaveFailedState();
        }
      } catch (e) {
        yield SaveFailedState();
      }
    } else if (event is DeleteNote) {
      try {
        yield LoadingState();
        bool _isDeleted = await hiveService.deleteNote(
          index: event.noteIndex,
        );
        if (_isDeleted) {
          yield DeleteSuccessState();
        } else {
          yield DeleteFailedState();
        }
      } catch (e) {
        yield DeleteFailedState();
      }
    }
  }
}
