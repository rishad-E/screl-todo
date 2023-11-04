import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screltodo/controller/database.dart';
import 'package:screltodo/model/mode.dart';
import 'package:screltodo/utils/dialoguebox.dart';
import 'package:screltodo/view/todolist.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        title: const Text("TODO"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(15),
        child: TodoList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createTask(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  createTask(BuildContext context) {
    final provider = Provider.of<DataBaseProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
            descriptcontroller: provider.descripcontroller,
            taskcontroller: provider.taskcontroller,
            onSave: () {
              onSaveButton(context);
              log("oncreate");
              Navigator.of(context).pop();
            },
            onCancel: () {
              Navigator.of(context).pop();
            });
      },
    );
  }

  Future<void> onSaveButton(BuildContext context) async {
    final provider = Provider.of<DataBaseProvider>(context, listen: false);

    final taskC = provider.taskcontroller.text.trimRight();
    final taskdescription = provider.descripcontroller.text.trimRight();

    if (taskC.isEmpty || taskdescription.isEmpty) {
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          content: Text("Task Added Sucessfully.. "),
        ),
      );
    }
    final todo = TodoModel(task: taskC, description: taskdescription);
    provider.addTodo(todo);
    provider.clearController();
    log("onsave");
  }
}
