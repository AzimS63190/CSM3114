import 'package:flutter/material.dart';
import 'notelist.dart';
import 'aboutus.dart';
import 'addnote.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<Note> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Buddy'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Note Buddy',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 8), // Small spacing
            Text(
              'Your personal note-taking app',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 40), // Increased spacing
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteList(notes: notes),
                  ),
                );
              },
              child: Text('Note List'),
            ),
            SizedBox(height: 20), // Additional spacing
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUs()),
                );
              },
              child: Text('About Us'),
            ),
          ],
        ),
      ),
    );
  }
}
