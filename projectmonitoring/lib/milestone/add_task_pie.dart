// add_task_pie.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'task_pie.dart';

class AddTaskPie extends StatefulWidget {
  @override
  _AddTaskPieState createState() => _AddTaskPieState();
}

class _AddTaskPieState extends State<AddTaskPie> {
  final _formKey = GlobalKey<FormState>();
  late String _taskNamePie;
  late String _detailsPie;
  late DateTime _dueDatePie = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task For Milestone'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Task Name'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a task name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _taskNamePie = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Details'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter task details';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _detailsPie = value!;
                  },
                ),
                ListTile(
                  title: Text('Due Date'),
                  subtitle: Text(_formatDate(_dueDatePie)),
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: _dueDatePie,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );

                    if (selectedDate != null && selectedDate != _dueDatePie) {
                      setState(() {
                        _dueDatePie = selectedDate;
                      });
                    }
                  },
                ),
                SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        TaskPie newTask =
                            TaskPie(_taskNamePie, _detailsPie, _dueDatePie);
                        Navigator.pop(context, newTask);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
