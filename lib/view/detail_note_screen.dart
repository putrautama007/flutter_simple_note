import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:simple_note/bloc/note_bloc.dart';
import 'package:simple_note/hive/hive_service.dart';
import 'package:simple_note/model/note_model.dart';
import 'package:simple_note/view/note_list_screen.dart';

class DetailNoteScreen extends StatefulWidget {
  final bool isEdit;
  final int noteIndex;
  final NoteModel noteModel;

  DetailNoteScreen({
    @required this.isEdit,
    this.noteIndex,
    this.noteModel,
  });

  @override
  _DetailNoteScreenState createState() => _DetailNoteScreenState();
}

class _DetailNoteScreenState extends State<DetailNoteScreen> {
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteBodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setupTextController();
  }

  @override
  void dispose() {
    super.dispose();
    _noteTitleController.dispose();
    _noteBodyController.dispose();
  }

  _setupTextController() {
    if (widget.noteModel != null) {
      _noteTitleController.text = widget.noteModel.noteTitle;
      _noteBodyController.text = widget.noteModel.noteBody;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteBloc(
        hiveService: HiveServiceImpl(
          hive: Hive,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isEdit ? "Edit Note" : "Create Note",
          ),
          leading: InkWell(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => NoteListScreen(),
              ),
            ),
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: BlocConsumer<NoteBloc, NoteState>(
          listener: (context, state) {
            if (state is SaveSuccessState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                    "Save note success",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            } else if (state is SaveFailedState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    "Save note failed",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            } else if (state is DeleteSuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => NoteListScreen(),
                ),
              );
            } else if (state is DeleteFailedState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    "Delete note failed",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(
                16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _noteTitleController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.grey[800],
                      ),
                      hintText: "Note Title",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: TextFormField(
                      controller: _noteBodyController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
                        hintText: "Notes",
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      minLines: 6,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        if (widget.isEdit) {
                          BlocProvider.of<NoteBloc>(context).add(
                            UpdateNote(
                              noteIndex: widget.noteIndex,
                              noteModel: NoteModel(
                                noteTitle: _noteTitleController.text,
                                noteBody: _noteBodyController.text,
                              ),
                            ),
                          );
                        } else {
                          BlocProvider.of<NoteBloc>(context).add(
                            CreateNote(
                              noteModel: NoteModel(
                                noteTitle: _noteTitleController.text,
                                noteBody: _noteBodyController.text,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  widget.isEdit != false
                      ? Padding(
                          padding: EdgeInsets.only(
                            top: 8.0,
                          ),
                          child: FlatButton(
                            color: Colors.red,
                            onPressed: () {
                              BlocProvider.of<NoteBloc>(context).add(
                                DeleteNote(
                                  noteIndex: widget.noteIndex,
                                ),
                              );
                            },
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
