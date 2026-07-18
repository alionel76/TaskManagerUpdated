import 'simple_task.dart';
import 'urgent_task.dart';

abstract class Task {
  String title;
  int number = 0;
  String priority; // low, medium, high
  String? deadline;
  bool isCompleted = false;
  static int compteur = 0;

  Task(this.title, this.priority, {this.deadline}) {
    //title = title[0].toUpperCase() + title.substring(1).toLowerCase(); // Effet de title en Python
    //priority = priority[0].toUpperCase() + priority.substring(1).toLowerCase(); // Effet de title en Python
    number = compteur++;
  }

  void markCompleted() {
    isCompleted = true;
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'priority': priority,
    'deadline': deadline,
    'isCompleted': isCompleted,
  };

  // Créer un objet Task à partir d'un Map (depuis JSON)
  factory Task.fromJson(Map<String, dynamic> json) {
    final title = json['title'] as String;
    final priority = json['priority'] as String;
    final deadline = json['deadline'] as String?;
    final isCompleted = json['isCompleted'] as bool;

    Task task;
    if (priority == "high") {
      task = UrgentTask(title, deadline: deadline);
    } else {
      task = SimpleTask(title, priority, deadline: deadline);
    }
    task.isCompleted = isCompleted;

    return task;
  }

  @override
  String toString() =>
      """Task ${number + 1} ----> [ Title => $title , Priority => $priority, deadline => $deadline, isCompleted => $isCompleted ]""";
}


