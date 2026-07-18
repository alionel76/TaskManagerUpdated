import 'dart:io';

import '../exceptions/task_exception.dart';

// Class de verification des saisies de l'utilisateur
abstract class CheckEntries {
  String checkBackupFileName();
  String checkTaskTitle();
  String checkTaskPriority();
  String checkTaskDeadline();

}

// Interface implementé avec classe générique
class CheckConsoleEntries<T> implements CheckEntries{

  T? content;

  List<String> get defaulPriority => ["high", "medium", "low"];

  @override
  String checkBackupFileName() {
    stdout.write("Nom du fichier de sauvegarde : ");
    String content = stdin.readLineSync().toString().toLowerCase();
    while(content.isEmpty) {
      catchInvalidEntriesException();
      stdout.write("Nom du fichier de sauvegarde : ");
      content = stdin.readLineSync().toString().toLowerCase();
    }
    return ("$content.json");
  }

  @override
  String checkTaskTitle() {
    stdout.write("Titre de la tache : ");
    String content = stdin.readLineSync().toString().toLowerCase();
    while(content.isEmpty) {
      catchInvalidEntriesException();
      stdout.write("Titre de la tache : ");
      content = stdin.readLineSync().toString().toLowerCase();
    }
    return content;
  }

  @override
  String checkTaskPriority() {
    stdout.write("Priorité de la tache (High, Medium, Low) : ");
    String content = stdin.readLineSync().toString().toLowerCase();

    while(content.isEmpty || !defaulPriority.contains(content)) {
      catchInvalidEntriesException();
      stdout.write("Priorité de la tache (High, Medium, Low) : ");
      content = stdin.readLineSync().toString().toLowerCase();
    }
    return content;
  }

  @override
  String checkTaskDeadline() {
    stdout.write("Date limite de la tache (JJ/MM/AAAA) : ");
    String content = stdin.readLineSync().toString().toLowerCase();
    while(content.isEmpty) {
      catchInvalidEntriesException();
      stdout.write("Date limite de la tache (JJ/MM/AAA) : ");
      content = stdin.readLineSync().toString().toLowerCase();
    }
    return content;
  }
}

