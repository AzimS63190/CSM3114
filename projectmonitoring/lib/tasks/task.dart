// task.dart
import 'package:flutter/material.dart';

class Task {
  String title;
  String details;
  DateTime dueDate;
  bool completed;

  Task({
    required this.title,
    required this.details,
    required this.dueDate,
    this.completed = false,
  });

  // Define a method to delete the task
  void deleteTask() {
    // Implement the logic to delete the task
    // For example, you can remove it from a list or perform any cleanup
  }

  // Define a method to mark the task as finished
  void finishTask() {
    // Implement the logic to finish the task
    // For example, you can move it to a completed tasks list
    this.completed = true;
  }
}
