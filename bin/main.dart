import 'dart:io';

import 'package:task_manager_updated/models/urgent_task.dart';
import 'package:task_manager_updated/models/simple_task.dart';
import 'package:task_manager_updated/services/task_services.dart';
import 'package:task_manager_updated/entry_checker/task_entry_checker.dart';

// Affichage par defaut
void defaultDisplay() {
  print("\n=== Gestionnaire de tâche ===");
  print("1. Ajouter une tâche");
  print("2. Afficher toutes les tâches");
  print("3. Marquer une tâche comme terminée");
  print("4. Retirer une tâche");
  print("5. Quitter");
}

// Execution principale
void main() {
  final service = TaskService();
  CheckEntries userEntry = CheckConsoleEntries<String>();
  String backupFileName = "data/${userEntry.checkBackupFileName()}";

  // Verifier si le fichier de sauvegarde existe
  if (File(backupFileName).existsSync()) {
    service.loadTasks(backupFileName);
  } else {
    print("Fichier inexistant. Créez le");
    backupFileName = "data/${userEntry.checkBackupFileName()}";
    final jsonbackupFile = File(backupFileName); jsonbackupFile.createSync();
    jsonbackupFile.writeAsStringSync("[]");
    service.loadTasks(backupFileName);
  }


  // Boucle du Gestionnaire de Tâche
  while (true) {

    defaultDisplay();

    final choice = stdin.readLineSync();
    switch (choice) {
      case "1":
        print("1. Ajouter une tâche");
        final title = userEntry.checkTaskTitle();
        final priority = userEntry.checkTaskPriority();
        stdout.write("Voulez-vos ajouter une date limite ? (Y / N) ");
        String dealineChoice = stdin.readLineSync().toString();

        if (dealineChoice == "Y") {
          final deadline = userEntry.checkTaskDeadline();
          final task = priority == "high"
              ? UrgentTask(title, deadline: deadline)
              : SimpleTask(title, priority, deadline: deadline);
          service.addTask(task, backupFileName);
          break;
        }
        final task = priority == "high"
            ? UrgentTask(title)
            : SimpleTask(title, priority);
        service.addTask(task, backupFileName);
        break;
      case "2":
        print("2. Afficher toutes les tâches");
        service.listTasks();
        break;
      case "3":
        print("3. Marquer la tâche comme terminée");
        final title = userEntry.checkTaskTitle();
        service.markCompleted(title, backupFileName);
        break;
      case "4":
        print("4. Retirer une tâche");
        final title = userEntry.checkTaskTitle();
        service.removeTask(title, backupFileName);
        break;
      case "5":
        print("5. Quitter");
        exit(0);
    }
  }
}
