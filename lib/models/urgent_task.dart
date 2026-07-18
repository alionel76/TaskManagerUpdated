import 'task.dart';

class UrgentTask extends Task {
  UrgentTask(String title, {String priority = "high", String? deadline})
      : super(title, priority, deadline: deadline);
}
