import 'package:flutter/material.dart';
import 'addnote.dart';

class NoteList extends StatefulWidget {
  final List<Note> notes;

  NoteList({required this.notes});

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note List'), // Set the title of the app bar
      ),
      body: ListView.builder(
        itemCount: widget.notes.length, // Number of items in the list
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                widget.notes[index].title), // Display the title of the note
            subtitle: Text(
                widget.notes[index].content), // Display the content of the note
            onTap: () async {
              // Navigate to the AddNotePage when a note is tapped
              final updatedNote = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNotePage(
                    note: widget.notes[
                        index], // Pass the selected note to the AddNotePage
                  ),
                ),
              );

              // Update the note if it's edited in the AddNotePage
              if (updatedNote != null) {
                setState(() {
                  widget.notes[index] = updatedNote;
                });
              }
            },
            trailing: IconButton(
              icon: Icon(Icons.delete), // Delete button
              onPressed: () {
                setState(() {
                  widget.notes.removeAt(index);
                  // Remove the note when the delete button is pressed
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to the AddNotePage when the FloatingActionButton is pressed
          final newNote = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotePage()),
          );

          // Add the new note to the list if it's created in the AddNotePage
          if (newNote != null) {
            setState(() {
              widget.notes.add(newNote);
            });
          }
        },
        child: Icon(Icons.add), // Icon for the FloatingActionButton
      ),
    );
  }
}
