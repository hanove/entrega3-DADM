import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'todo_list_screen.dart';
import 'todo_service.dart';

void main() {
  GetIt.I.registerSingleton<TodoService>(TodoService());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoListScreen(),
    );
  }
}