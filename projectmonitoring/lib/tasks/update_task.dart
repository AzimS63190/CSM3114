// update_task.dart
import 'package:flutter/material.dart';
import 'task.dart';

class UpdateTaskPage extends StatefulWidget {
  final Task task;

  const UpdateTaskPage({Key? key, required this.task}) : super(key: key);

  @override
  _UpdateTaskPageState createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Task"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title: ${widget.task.title}"),
            SizedBox(height: 16),
            Text("Details: ${widget.task.details}"),
            SizedBox(height: 16),
            Text("Due Date: ${widget.task.dueDate.toLocal().toString().split(' ')[0]}"),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _deleteTask(context),
                  child: Text('Delete'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _finishTask(context),
                  child: Text('Finish'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _deleteTask(BuildContext context) {
    widget.task.deleteTask();
    Navigator.pop(context, true);
  }

  void _finishTask(BuildContext context) {
    widget.task.finishTask();

    // Get the current time
    DateTime currentTime = DateTime.now();

    // Update the dueDate to the current time
    widget.task.dueDate = currentTime;

    Navigator.pop(context, widget.task);
  }
}
