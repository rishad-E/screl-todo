import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screltodo/controller/database.dart';
import 'package:screltodo/view/add_todo.dart';
import 'package:screltodo/view/todo_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataBaseProvider>(context, listen: false);
    provider.getAllTodo();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        title: const Text(
          "TODO",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(15),
        child: TodoList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.clearController();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTodoItem()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
