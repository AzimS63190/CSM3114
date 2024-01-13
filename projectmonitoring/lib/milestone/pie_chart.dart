// pie_chart.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'add_task_pie.dart';  // Update import statement
import 'task_pie.dart';      // Update import statement

class PieChart extends StatefulWidget {
  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  List<TaskPie> _tasksPie = [];  // Update the type to TaskPie
  double _completionPercentage = 0.0;

  @override
  Widget build(BuildContext context) {
    // Sort the tasks based on the due date
    _tasksPie.sort((a, b) => a.compareTo(b));

    return Scaffold(
      appBar: AppBar(
        title: Text('Project Milestones'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 8.0,
              percent: _completionPercentage,
              center: Text(
                '${(_completionPercentage * 100).toStringAsFixed(0)}%',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              progressColor: Colors.blue,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: _tasksPie.isEmpty
                  ? Center(
                      child: Text('No tasks available'),
                    )
                  : ListView.builder(
                      itemCount: _tasksPie.length,
                      itemBuilder: (context, index) {
                        return _buildTaskItem(_tasksPie[index]);
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          TaskPie? newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPie()),  // Update to AddTaskPie
          );

          if (newTask != null) {
            setState(() {
              _tasksPie.add(newTask);
              _updateCompletionPercentage();
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskItem(TaskPie task) {  // Update the parameter type to TaskPie
    return ListTile(
      title: Text(task.taskNamePie),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.detailsPie),
          Text(
            'Due Date: ${_formatDate(task.dueDatePie)}',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: task.isCompletedPie ? Icon(Icons.refresh) : Icon(Icons.check),
            onPressed: () {
              setState(() {
                task.isCompletedPie = !task.isCompletedPie;
                _updateCompletionPercentage();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteTask(task);
            },
          ),
        ],
      ),
    );
  }

  void _deleteTask(TaskPie task) {  // Update the parameter type to TaskPie
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                setState(() {
                  _tasksPie.remove(task);
                  _updateCompletionPercentage();
                });
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _updateCompletionPercentage() {
    int completedTasks = _tasksPie.where((task) => task.isCompletedPie).length;
    int totalTasks = _tasksPie.length;

    setState(() {
      _completionPercentage = totalTasks > 0 ? completedTasks / totalTasks : 0.0;
    });
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
