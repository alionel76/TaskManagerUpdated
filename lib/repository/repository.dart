import 'dart:io';
import 'dart:convert';
import '../models/task.dart';
import '../exceptions/task_exception.dart';

abstract class IRepository<T> {
  void add(T item);
  void remove(T item);
  List<T> getAll();
  void save();
  void load();
}

class JsonTaskRepository implements IRepository<Task> {
  final String filePath;
  List<Task> _tasks = [];

  JsonTaskRepository(this.filePath);

  @override
  void add(Task item) => _tasks.add(item);

  @override
  void remove(Task item) => _tasks.removeWhere((t) => t.title == item.title);

  @override
  List<Task> getAll() => List.unmodifiable(_tasks);

  @override
  void save() {
    try {
      final file = File(filePath);
      // Create directory if it doesn't exist
      final directory = file.parent;
      if (!directory.existsSync() && directory.path != '.') {
        directory.createSync(recursive: true);
      }

      final jsonList = _tasks.map((task) => task.toJson()).toList();
      final encoder = JsonEncoder.withIndent("    ");
      file.writeAsStringSync(encoder.convert(jsonList));
    } catch (e) {
      throw DataPersistenceException("Erreur lors de la sauvegarde : $e");
    }
  }

  @override
  void load() {
    try {
      final file = File(filePath);
      if (!file.existsSync()) {
        _tasks = [];
        return;
      }

      final contents = file.readAsStringSync();
      if (contents.isEmpty) {
        _tasks = [];
        return;
      }

      final jsonList = jsonDecode(contents) as List;
      _tasks = jsonList.map((json) => Task.fromJson(json)).toList();
    } catch (e) {
      throw DataPersistenceException("Erreur lors du chargement : $e");
    }
  }
}
