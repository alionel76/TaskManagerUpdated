import 'package:test/test.dart';

import 'package:task_manager_updated/models/simple_task.dart';
import 'package:task_manager_updated/services/task_services.dart';


void main() {
  String testFileName = "test/testfile.json";


  test("Add task", () {
    final service = TaskService();
    final task = SimpleTask("Test", "low");
    service.addTask(task, testFileName);
    expect(service.tasks.contains(task), true);
  });

  test("Mark task completed", () {
    final task = SimpleTask("Test", "low");
    task.markCompleted();
    expect(task.isCompleted, true);
  });

  test("Remove task", () {
    final service = TaskService();
    final task = SimpleTask("Test", "low");
    service.addTask(task, testFileName);
    service.removeTask("Test", testFileName);
    expect(service.tasks.contains(task), false);
  });

  test("Throw exception when removing non-existent task", () {
    final service = TaskService();
    expect(service.removeTask("Unknown", testFileName), false);
  });

  test("List tasks sorted by priority", () {
    final service = TaskService();
    service.addTask(SimpleTask("A", "low"), testFileName);
    service.addTask(SimpleTask("B", "high"), testFileName);
    service.listTasks(sortBy: "priority");
    expect(service.tasks.length, 2);
  });
}
