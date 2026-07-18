import 'dart:io';
import 'package:test/test.dart';
import 'package:task_manager_updated/models/urgent_task.dart';
import 'package:task_manager_updated/models/task.dart';
import 'package:task_manager_updated/services/task_services.dart';
import 'package:task_manager_updated/repository/repository.dart';

void main() {
  const testFileName = "test/test_tasks.json";
  late JsonTaskRepository repository;
  late TaskService service;

  setUp(() {
    repository = JsonTaskRepository(testFileName);
    service = TaskService(repository);
  });

  tearDown(() {
    final file = File(testFileName);
    if (file.existsSync()) {
      file.deleteSync();
    }
  });

  group('Tests de TaskService', () {
    test("Ajouter une tâche", () {
      final task = UrgentTask("Test", priority: "low");
      service.addTask(task);
      expect(service.tasks.length, 1);
      expect(service.tasks.first.title, "Test");
    });

    test("Marquer une tache comme terminée", () {
      final task = UrgentTask("Test");
      service.addTask(task);
      service.markCompleted("Test");
      expect(service.tasks.first.isCompleted, true);
    });

    test("Retirer une tâche", () {
      final task = UrgentTask("Test");
      service.addTask(task);
      service.removeTask("Test");
      expect(service.tasks.isEmpty, true);
    });
  });

  group('Tests de Persistance', () {
    test("Sauvegarde et chargement des données", () {
      service.addTask(UrgentTask("Simple", priority: "low"));
      service.addTask(UrgentTask("Urgent", deadline: "01/01/2025"));
      
      final newRepository = JsonTaskRepository(testFileName);
      final newService = TaskService(newRepository);
      newService.loadTasks();

      expect(newService.tasks.length, 2);
      expect(newService.tasks.firstWhere((t) => t.title == "Urgent").priority, "high");
    });
  });

  group('Tests de Modèles', () {
    test("Incrémentation du compteur de numéro", () {
      final t1 = UrgentTask("A");
      final t2 = UrgentTask("B");
      expect(t1.number < t2.number, true);
    });
  });
}
