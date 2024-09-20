import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  final Function(String) onAddTask;

  AddTaskScreen({required this.onAddTask});

  @override
  Widget build(BuildContext context) {
    TextEditingController _taskController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Tugas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(labelText: 'Masukkan tugas baru'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onAddTask(_taskController.text);
                Navigator.pop(context);
              },
              child: Text('Tambah Tugas'),
            ),
          ],
        ),
      ),
    );
  }
}
