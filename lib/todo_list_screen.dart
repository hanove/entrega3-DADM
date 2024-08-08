import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'todo_service.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final todoService = GetIt.I<TodoService>();

  @override
  void initState() {
    super.initState();
    todoService.addListener(_update);
  }

  @override
  void dispose() {
    todoService.removeListener(_update);
    super.dispose();
  }

  void _update() {
    setState(() {});
  }

  void _promptAddTodoItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New task'),
          content: TextField(
            autofocus: true,
            onSubmitted: (val) {
              todoService.addTodoItem(val);
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Column(
        children: [
          Padding( //put this in another file?
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Completed Tasks: ${todoService.completedTaskCount}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoService.todoItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    todoService.todoItems[index],
                    style: TextStyle(
                      decoration: todoService.completedTasks.contains(index)
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: todoService.completedTasks.contains(index),
                    onChanged: (bool? value) {
                      todoService.toggleTaskCompletion(index);
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => todoService.removeTodoItem(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _promptAddTodoItem,
        tooltip: 'Add task',
        child: const Icon(Icons.add),
      ),
    );
  }
}