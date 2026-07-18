import 'dart:io';
import 'dart:convert';

import '../models/task.dart';
import '../exceptions/task_exception.dart';



class TaskService {

  List<Task> tasks = [];

  void loadTasks(String localLileName) {

    final file = File(localLileName);
    String contents = file.readAsStringSync();

    if (!file.existsSync()) {
      tasks = [];
      return;
    }

    final jsonList = jsonDecode(contents) as List;
    tasks = jsonList.map((json) => Task.fromJson(json)).toList();
  }

  void saveTasks(String localLileName) {
    final file = File(localLileName);

    // Transformer la liste de Task en liste de Map
    List<Map<String, dynamic>> jsonList = tasks.map((task) => task.toJson()).toList();

    // Encoder en JSON et écrire dans le fichier avec indentation
    final jsonIdent = JsonEncoder.withIndent("    " );
    final jsonString = jsonIdent.convert(jsonList);
    file.writeAsStringSync(jsonString);
  }

  void addTask(Task task, String localLileName) {
    tasks.add(task);
    saveTasks(localLileName);
  }

  bool removeTask(String title, String localLileName) {
    try {
      final task = tasks.firstWhere((t) => t.title == title,
          orElse: () => throw TaskNotFoundException("Tâche $title non trouvée"));
      tasks.remove(task);
      saveTasks(localLileName);
      return true;
    } on TaskNotFoundException catch (exception) {
      print(exception);
      return false;
    }
  }

  void markCompleted(String title, String localLileName) {
    try {
      final task = tasks.firstWhere((t) => t.title == title,
          orElse: () => throw TaskNotFoundException("Tâche $title non trouvée"));
      task.markCompleted();
      saveTasks(localLileName);
    } on TaskNotFoundException catch (exception) {
      print(exception);
    }
  }

  void listTasks({String sortBy = "priority"}) {
    List<Task> sorted = [...tasks];
    if (sortBy == "priority") {
      sorted.sort((a, b) => a.priority.compareTo(b.priority));
    } else if (sortBy == "date") {
      sorted.sort((a, b) =>
          (a.deadline ?? "").compareTo(b.deadline ?? ""));
    }
    sorted.forEach(print);
  }
}
