import 'package:flutter/material.dart';
import 'package:statckmod_app/repository/repository.dart';
import 'package:statckmod_app/services/firebase_services.dart';

import '../../../models/models.dart';

enum TaskStatus { pending, inProgress, completed }

enum TaskPriority { low, medium, high }

class HomeProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> _completedTask = [];
  List<Task> _inCompletedTask = [];

  List<Task> _pendingTask = [];
  List<Task> _dueTask = [];
  List<Task> _selectedTask = [];

  String? _taskError;

  String? _taskName;
  String? _taskDescription;
  DateTime? _dueDate;
  TaskStatus? _status;
  TaskPriority? _priority;

  List<Task> get tasks => _tasks;
  List<Task> get completedTask => _completedTask;
  List<Task> get inCompletedTask => _inCompletedTask;
  List<Task> get selectedTask => _selectedTask;
  List<Task> get pendingTask => _pendingTask;
  List<Task> get dueTask => _dueTask;
  String? get taskError => _taskError;
  String? get taskName => _taskName;
  String? get taskDescription => _taskDescription;
  DateTime? get dueDate => _dueDate;
  TaskStatus? get status => _status;
  TaskPriority? get priority => _priority;

  void initialize() async {
    final taksRes = await FireColudStoreService().getTasks();
    if (taksRes is Exception) {
      _taskError = taksRes.toString();
    } else {
      _tasks = taksRes;
      debugPrint('tasks ${_tasks.map(
        (e) {
          return e.toMap();
        },
      )}');
      _completedTask =
          _tasks.where((element) => element.status == 'completed').toList();
      _pendingTask =
          _tasks.where((element) => element.status == 'pending').toList();
      _inCompletedTask = _tasks.where((element) {
        return (element.status != 'completed' && element.status != 'pending');
      }).toList();
      _dueTask = _tasks
          .where((element) =>
              DateTime.parse(element.dueDate).isBefore(DateTime.now()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    final repo = Repository();
    await repo.addTask(task);
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    final index = _tasks.indexWhere((element) => element.id == task.id);
    final repo = Repository();
    _tasks[index] = task;
    await repo.updateTask(task);
    notifyListeners();
  }

  void selectTask(Task task) {
    _selectedTask.add(task);
    notifyListeners();
  }

  void setTaksList({required bool v, required List<Task> tasks}) {
    if (v = true) {
      _selectedTask = tasks;
      notifyListeners();
    } else {
      _selectedTask.clear();
      notifyListeners();
    }
    debugPrint('selected task ${_selectedTask.map((e) => e.toMap())}');
  }

  void setTaksTitle(String value) {
    _taskName = value;
    notifyListeners();
  }

  void filterTasksByDate(DateTime date) {
    _selectedTask = [];

    _selectedTask.addAll(
      _tasks
          .where((task) => DateTime.parse(task.dueDate).isBefore(date))
          .toList(),
    );
    notifyListeners();
  }

  void setTaskDescription(String value) {
    _taskDescription = value;
    notifyListeners();
  }

  void setDueDate(DateTime value) {
    _dueDate = value;
    notifyListeners();
  }

  void setStatus() {
    _status = _status == TaskStatus.completed
        ? TaskStatus.pending
        : TaskStatus.completed;
    notifyListeners();
  }

  void setPriority(TaskPriority value) {
    _priority = value;

    notifyListeners();
  }
}
