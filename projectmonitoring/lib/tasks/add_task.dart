// add_task.dart
import 'package:flutter/material.dart';
import 'package:projectmonitoring/tasks/task.dart';

class AddTaskPage extends StatefulWidget {
  final Function(Task) onTaskSubmitted;

  const AddTaskPage({Key? key, required this.onTaskSubmitted})
      : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late TextEditingController _titleController;
  late TextEditingController _detailsController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _detailsController = TextEditingController();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _detailsController,
                decoration: InputDecoration(labelText: 'Details'),
                maxLines: 2,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text("Due Date:"),
                  SizedBox(width: 16),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      "${_selectedDate.toLocal()}".split(' ')[0],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () => _submitTask(context),
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    ))!;
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void _submitTask(BuildContext context) {
    // Validate if title and details are not empty
    if (_titleController.text.isEmpty || _detailsController.text.isEmpty) {
      // Show an alert or snackbar for validation
      return;
    }

    // Create a new task object
    Task newTask = Task(
      title: _titleController.text,
      details: _detailsController.text,
      dueDate: _selectedDate,
    );

    // Pass the new task back to HomePage using the callback
    widget.onTaskSubmitted(newTask);

    // Close the AddTaskPage
    Navigator.pop(context);
  }
}
