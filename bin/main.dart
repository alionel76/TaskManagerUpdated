import 'dart:io';

import 'package:task_manager_updated/models/urgent_task.dart';
import 'package:task_manager_updated/services/task_services.dart';
import 'package:task_manager_updated/entry_checker/task_entry_checker.dart';
import 'package:task_manager_updated/repository/repository.dart';

void defaultDisplay() {
  print("\n=== Gestionnaire de tâches ===");
  print("1. Ajouter une tâche");
  print("2. Afficher toutes les tâches");
  print("3. Marquer une tâche comme terminée");
  print("4. Retirer une tâche");
  print("5. Quitter");
  stdout.write("Choix : ");
}

void main() {
  CheckEntries userEntry = CheckConsoleEntries();
  String fileName = userEntry.checkBackupFileName();
  String backupPath = "data/$fileName";

  final repository = JsonTaskRepository(backupPath);
  final service = TaskService(repository);

  // Charger les tâches existantes
  try {
    service.loadTasks();
    print("Données chargées depuis $backupPath");
  } catch (e) {
    print("Erreur lors du chargement : $e");
  }

  while (true) {
    defaultDisplay();
    final choice = stdin.readLineSync();
    
    switch (choice) {
      case "1":
        final title = userEntry.checkTaskTitle();
        final priority = userEntry.checkTaskPriority();
        
        stdout.write("Ajouter une date limite ? (y/n) : ");
        final hasDeadline = stdin.readLineSync()?.toLowerCase() == 'y';
        String? deadline;
        if (hasDeadline) {
          deadline = userEntry.checkTaskDeadline();
        }

        // Utilisation exclusive de UrgentTask (seule classe concrète)
        final task = UrgentTask(title, priority: priority, deadline: deadline);
        
        service.addTask(task);
        print("Tâche ajoutée avec succès.");
        break;

      case "2":
        stdout.write("Trier par (1: priorité, 2: date) [par défaut: priorité] : ");
        final sortChoice = stdin.readLineSync();
        final sortBy = (sortChoice == "2") ? "date" : "priority";
        service.listTasks(sortBy: sortBy);
        break;
// ... reste du code identique

      case "3":
        final title = userEntry.checkTaskTitle();
        service.markCompleted(title);
        break;

      case "4":
        final title = userEntry.checkTaskTitle();
        if (service.removeTask(title)) {
          print("Tâche retirée.");
        }
        break;

      case "5":
        print("Au revoir !");
        exit(0);

      default:
        print("Choix invalide.");
    }
  }
}
