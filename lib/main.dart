import 'package:flutter/material.dart';
import 'add_task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-Do List",
      theme: ThemeData(
        primaryColor: Colors.purpleAccent,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.purpleAccent,
          secondary: Colors.purpleAccent,
        ),
      ),
      home: const TodoListScreen(),
    );
  }
}

class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> _tasks = [];

  void _addTask(String task) {
    setState(() {
      _tasks.add(Task(title: task));
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _tasks.isEmpty
            ? const Center(
                child: Text(
                  "Belum ada tugas. Tambahkan tugas baru!",
                  style: TextStyle(fontSize: 18),
                ),
              )
            : ListView.separated(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.purpleAccent,
                        width: 2.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6.0,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Icon(
                        _tasks[index].isCompleted
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: _tasks[index].isCompleted
                            ? Colors.purple
                            : Colors.grey,
                      ),
                      title: Text(
                        _tasks[index].title,
                        style: TextStyle(
                          fontSize: 18,
                          decoration: _tasks[index].isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      onTap: () => _toggleTaskCompletion(index),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _tasks.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(onAddTask: _addTask),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.purpleAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
