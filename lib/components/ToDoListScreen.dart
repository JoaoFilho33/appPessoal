import 'package:flutter/material.dart';
import '../databases/ToDoDatabase.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final ToDoDatabase _toDoDatabase = ToDoDatabase();
  late List<Map<String, dynamic>> tasks;

  TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    tasks = await _toDoDatabase.getAllTasks();
    setState(() {});
  }

  void _addTask(String task) async {
    await _toDoDatabase.insertTask(task);
    _loadTasks();
  }

  void _removeTask(int index) async {
    await _toDoDatabase.deleteTask(tasks[index]['id']);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de tarefas'),
      ),
      body: Column(
        children: [
          TextField(
            controller: taskController,
            decoration: InputDecoration(
              labelText: 'Nova Tarefa',
              suffixIcon: IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _addTask(taskController.text),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: tasks.map((task) {
                  return ListTile(
                    title: Text(task['title']),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeTask(tasks.indexOf(task)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
