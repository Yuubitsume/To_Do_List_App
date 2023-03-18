import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:google_fonts/google_fonts.dart';

import '../auth/auth.dart';
import '../page/register.dart';
import 'package:flutter_to_do_list/main.dart';
import '../firebase/firebase_options.dart';
import 'package:flutter_to_do_list/main.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<String> _tasks = [];

  _AuthScreenState createState() => _AuthScreenState();

  final TextEditingController _taskController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _addTask(String task) {
    setState(() {
      _tasks.add(task);
    });
    _taskController.clear();
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  Widget _buildTaskList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(_tasks[index]),
          onDismissed: (direction) {
            _removeTask(index);
          },
          child: Card(
            child: ListTile(
              title: Text(_tasks[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _removeTask(index);
                },
              ),
            ),
          ),
        );
      },
      itemCount: _tasks.length,
    );
  }

  Widget _buildAddTaskForm() {
    return TextField(
      controller: _taskController,
      decoration: const InputDecoration(
        labelText: 'Ajouter une tâche',
      ),
      onSubmitted: (value) {
        _addTask(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildAddTaskForm(),
          ),
          Expanded(
            child: _buildTaskList(),
          ),
          ElevatedButton(
            onPressed: () async {
              FirebaseAuth.instance.signOut();
            },
            child: const Text('Déconnexion'),
          )
        ],
      ),
    );
  }
}

class _AuthScreenState {}
