import 'task.dart';

class UrgentTask extends Task {
  UrgentTask(String title, {String? deadline})
      : super(title, "high", deadline: deadline);
}