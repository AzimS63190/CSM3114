// task.dart
class TaskPie {
  String taskNamePie;
  String detailsPie;
  DateTime dueDatePie;
  bool isCompletedPie;

  TaskPie(this.taskNamePie, this.detailsPie, this.dueDatePie, {this.isCompletedPie = false});

  // Helper method to compare tasks based on due date
  int compareTo(TaskPie other) {
    return this.dueDatePie.compareTo(other.dueDatePie);
  }
}
