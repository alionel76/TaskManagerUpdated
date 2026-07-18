import 'urgent_task.dart';

abstract class Task {
  String title;
  late int number;
  String priority; // low, medium, high
  String? deadline;
  bool isCompleted = false;
  static int _compteur = 0;

  Task(this.title, this.priority, {this.deadline}) {
    number = ++_compteur;
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

  factory Task.fromJson(Map<String, dynamic> json) {
    final title = json['title'] as String;
    final priority = json['priority'] as String;
    final deadline = json['deadline'] as String?;
    final isCompleted = json['isCompleted'] as bool;

    // Seule UrgentTask est instanciée car c'est l'unique classe concrète
    final task = UrgentTask(title, priority: priority, deadline: deadline);
    task.isCompleted = isCompleted;
    return task;
  }

  @override
  String toString() {
    final status = isCompleted ? "[X]" : "[ ]";
    return "$status $number. $title (Priorité: $priority${deadline != null ? ', Échéance: $deadline' : ''})";
  }
}


