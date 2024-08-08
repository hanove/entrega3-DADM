import 'package:flutter/material.dart';

class TodoService extends ChangeNotifier {
  final List<String> _todoItems = [];
  final Set<int> _completedTasks = {};

  List<String> get todoItems => _todoItems;
  int get completedTaskCount => _completedTasks.length;
  Set<int> get completedTasks => _completedTasks;

  void addTodoItem(String task) {
    if (task.isNotEmpty) {
      _todoItems.add(task);
      notifyListeners();
    }
  }

  void removeTodoItem(int index) {
    _todoItems.removeAt(index);
    _completedTasks.remove(index);
    notifyListeners();
  }

  void toggleTaskCompletion(int index) {
    if (_completedTasks.contains(index)) {
      _completedTasks.remove(index);
    } else {
      _completedTasks.add(index);
    }
    notifyListeners();
  }
}