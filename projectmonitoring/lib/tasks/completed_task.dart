// completed_task.dart
import 'package:flutter/material.dart';
import 'package:projectmonitoring/tasks/task.dart';
import 'task.dart';

class CompletedTaskPage extends StatefulWidget {
  final List<Task> completedTasks;

  const CompletedTaskPage({Key? key, required this.completedTasks}) : super(key: key);

  @override
  _CompletedTaskPageState createState() => _CompletedTaskPageState();
}

class _CompletedTaskPageState extends State<CompletedTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Completed Tasks"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.completedTasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.completedTasks[index].title),
            subtitle: Text(widget.completedTasks[index].details),
            trailing: Text(
              'Finished On: ${widget.completedTasks[index].dueDate.toLocal().toString().split(' ')[0]}',
            ),
          );
        },
      ),
    );
  }
}
