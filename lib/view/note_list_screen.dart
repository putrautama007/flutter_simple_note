import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:simple_note/hive/hive_service.dart';
import 'package:simple_note/model/note_model.dart';
import 'package:simple_note/view/detail_note_screen.dart';
import 'package:simple_note/bloc/note_bloc.dart';

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteBloc(
        hiveService: HiveServiceImpl(
          hive: Hive,
        ),
      )..add(
          GetNoteList(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Simple Note',
          ),
        ),
        body: BlocConsumer<NoteBloc, NoteState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadSuccessState) {
              return _noteListWidget(
                state.noteList,
              );
            } else if (state is LoadEmptyDataState) {
              return _noDataWidget();
            } else if (state is LoadFailedState) {
              return _errorWidget();
            } else {
              return _loadingWidget();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => DetailNoteScreen(
                isEdit: false,
              ),
            ),
          ),
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _noteListWidget(List<NoteModel> noteList) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: noteList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => DetailNoteScreen(
                    isEdit: true,
                    noteIndex: index,
                    noteModel: noteList[index],
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                ),
                padding: EdgeInsets.all(
                  8.0,
                ),
                margin: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: 16.0,
                      ),
                      child: Icon(
                        Icons.note,
                        color: Colors.blue,
                        size: 48.0,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            noteList[index].noteTitle,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            noteList[index].noteBody,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

  Widget _noDataWidget() => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note,
              color: Colors.blue,
              size: 200.0,
            ),
            Text(
              "Empty Data",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      );

  Widget _errorWidget() => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
              size: 200.0,
            ),
            Text(
              "An Error Occurred",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      );

  Widget _loadingWidget() => Center(
        child: CircularProgressIndicator(),
      );
}
