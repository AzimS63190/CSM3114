// homepage.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectmonitoring/milestone/pie_chart.dart';
import 'aboutus.dart';
import 'package:projectmonitoring/tasks/task.dart';
import 'package:projectmonitoring/tasks/add_task.dart';
import 'package:projectmonitoring/tasks/update_task.dart';
import 'package:projectmonitoring/tasks/completed_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  int _currentIndex = 0;
  List<Task> _tasks = [];
  List<Task> _completedTasks = [];

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    _tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));

    return Scaffold(
      appBar: AppBar(
        title: Text("Project Monitoring"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (()=>signOut()),
            icon: Icon(Icons.exit_to_app_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 107, 80, 154),
              boxShadow: [
                BoxShadow(
                  color: Colors.black87,
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => _navigateToUpdateTask(context, _tasks[index]),
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(_tasks[index].title),
                      subtitle: Text(_tasks[index].details),
                      trailing: Text(
                        'Due: ${_tasks[index].dueDate.toLocal().toString().split(' ')[0]}',
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddTaskPage(
                              onTaskSubmitted: (newTask) {
                                setState(() {
                                  _tasks.add(newTask);
                                });
                              },
                            )),
                  );
                },
                child: Text('New'),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  _navigateToCompletedTasks(context);
                },
                child: Text('Completed'),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (int index) {
          _onTabTapped(index, context);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Milestone',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logo_dev_sharp),
            label: 'About Us',
          ),
        ],
      ),
    );
  }

  void _onTabTapped(int index, BuildContext context) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PieChart()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AboutUs()),
      );
    }
  }

  void _navigateToUpdateTask(BuildContext context, Task task) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateTaskPage(task: task)),
    );

    if (result == true) {
      setState(() {
        _tasks.remove(task);
      });
    } else if (result is Task) {
      setState(() {
        _tasks.remove(task);
        _completedTasks.add(result);
      });
    }
  }

  void _navigateToCompletedTasks(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CompletedTaskPage(completedTasks: _completedTasks)),
    );

    if (result != null && result is List<Task>) {
      setState(() {
        _tasks.removeWhere((task) => result.contains(task));
      });
    }
  }
}

