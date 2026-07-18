import '../models/task.dart';
import '../exceptions/task_exception.dart';
import '../repository/repository.dart';

class TaskService {
  final IRepository<Task> _repository;

  TaskService(this._repository);

  List<Task> get tasks => _repository.getAll();

  void loadTasks() {
    _repository.load();
  }

  void saveTasks() {
    _repository.save();
  }

  void addTask(Task task) {
    _repository.add(task);
    saveTasks();
  }

  bool removeTask(String title) {
    try {
      final task = tasks.firstWhere(
        (t) => t.title == title,
        orElse: () => throw TaskNotFoundException("Tâche '$title' non trouvée"),
      );
      _repository.remove(task);
      saveTasks();
      return true;
    } on TaskNotFoundException catch (e) {
      print(e);
      return false;
    }
  }

  void markCompleted(String title) {
    try {
      final task = tasks.firstWhere(
        (t) => t.title == title,
        orElse: () => throw TaskNotFoundException("Tâche '$title' non trouvée"),
      );
      task.markCompleted();
      saveTasks();
    } on TaskNotFoundException catch (e) {
      print(e);
    }
  }

  void listTasks({String sortBy = "priority"}) {
    List<Task> sorted = List.from(tasks);
    if (sortBy == "priority") {
      // Custom order: high -> medium -> low
      const priorityOrder = {"high": 0, "medium": 1, "low": 2};
      sorted.sort((a, b) => (priorityOrder[a.priority] ?? 3)
          .compareTo(priorityOrder[b.priority] ?? 3));
    } else if (sortBy == "date") {
      sorted.sort((a, b) => (a.deadline ?? "").compareTo(b.deadline ?? ""));
    }
    
    if (sorted.isEmpty) {
      print("Aucune tâche à afficher.");
    } else {
      for (var task in sorted) {
        print(task);
      }
    }
  }
}
