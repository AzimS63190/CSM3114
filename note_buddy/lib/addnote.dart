import 'package:flutter/material.dart';

class AddNotePage extends StatefulWidget {
  final Note? note;

  AddNotePage({this.note});

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  // Controllers for handling text input
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();

    // Initialize text controllers with values from the provided note (if any)
    titleController = TextEditingController(text: widget.note?.title ?? '');
    contentController = TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Set the title of the app bar based on whether it's a new note or an update
        title: Text(widget.note == null ? 'Add Note' : 'Update Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text field for entering the title of the note
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16), // Vertical spacing
            // Text field for entering the content of the note
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            SizedBox(height: 16), // Vertical spacing
            // Button for submitting the note
            ElevatedButton(
              onPressed: () {
                // When the button is pressed, pop the current screen and pass the new/updated note
                Navigator.pop(
                  context,
                  Note(
                    title: titleController.text,
                    content: contentController.text,
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

// Model class representing a Note with a title and content
class Note {
  String title;
  String content;

  // Constructor to initialize a Note with a title and content
  Note({
    required this.title,
    required this.content,
  });
}
