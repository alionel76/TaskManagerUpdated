class TaskNotFoundException implements Exception {
  final String message;

  TaskNotFoundException(this.message);

  @override
  String toString() => "TaskNotFoundException : $message";
}


class InvalidEntriesException implements Exception {
  final String message;

  InvalidEntriesException(this.message);

  @override
  String toString() => "InvalidEntriesException : $message";
}

void catchInvalidEntriesException() {
  try {
    throw InvalidEntriesException("Saisie invalide. Réessayer");
  } on InvalidEntriesException catch (errorMessage) {
    print(errorMessage);
  }
}