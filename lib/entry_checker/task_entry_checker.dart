import 'dart:io';
import '../exceptions/task_exception.dart';

abstract class CheckEntries {
  String checkBackupFileName();
  String checkTaskTitle();
  String checkTaskPriority();
  String checkTaskDeadline();
}

class CheckConsoleEntries implements CheckEntries {
  final List<String> _validPriorities = ["high", "medium", "low"];

  String _inputWithValidation(String prompt, bool Function(String) validator, String errorMessage) {
    while (true) {
      stdout.write(prompt);
      String? input = stdin.readLineSync()?.trim().toLowerCase();
      if (input != null && validator(input)) {
        return input;
      }
      print("Erreur : $errorMessage");
    }
  }

  @override
  String checkBackupFileName() {
    return _inputWithValidation(
      "Nom du fichier de sauvegarde : ",
      (s) => s.isNotEmpty,
      "Le nom du fichier ne peut pas être vide.",
    ) + ".json";
  }

  @override
  String checkTaskTitle() {
    return _inputWithValidation(
      "Titre de la tâche : ",
      (s) => s.isNotEmpty,
      "Le titre ne peut pas être vide.",
    );
  }

  @override
  String checkTaskPriority() {
    return _inputWithValidation(
      "Priorité (high, medium, low) : ",
      (s) => _validPriorities.contains(s),
      "Priorité invalide. Choisissez parmi : ${_validPriorities.join(', ')}.",
    );
  }

  @override
  String checkTaskDeadline() {
    final dateRegExp = RegExp(r"^\d{2}/\d{2}/\d{4}$");
    return _inputWithValidation(
      "Date limite (JJ/MM/AAAA) : ",
      (s) => dateRegExp.hasMatch(s),
      "Format de date invalide (attendu: JJ/MM/AAAA).",
    );
  }
}

