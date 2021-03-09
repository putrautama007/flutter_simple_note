import 'package:flutter/material.dart';
import 'package:simple_note/view/note_list_screen.dart';

import 'hive/hive_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveUtils.initializeHive();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Note',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NoteListScreen(),
    );
  }
}
