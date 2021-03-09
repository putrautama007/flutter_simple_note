import 'package:flutter/material.dart';

class DetailNoteScreen extends StatelessWidget {
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteBodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
          ],
        ),
      ),
    );
  }
}
