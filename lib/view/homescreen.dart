import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screltodo/controller/database.dart';
import 'package:screltodo/view/add_todo.dart';
import 'package:screltodo/view/todo_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<DataBaseProvider>(context, listen: false).getAllTodo();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        title: const Text(
          "TODO",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Consumer<DataBaseProvider>(
          builder: (context, value, child) {
            return const TodoList();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTodoItem()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
