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

class DataPersistenceException implements Exception {
  final String message;
  DataPersistenceException(this.message);
  @override
  String toString() => "DataPersistenceException : $message";
}
