import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screltodo/controller/database.dart';
import 'package:screltodo/view/edit_todo.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<DataBaseProvider>(context, listen: false).getAllTodo();
    return Scaffold(
      body: SafeArea(child: Consumer<DataBaseProvider>(
        builder: (context, provider, child) {
          return ListView.separated(
            itemCount: provider.todoItems.length,
            itemBuilder: (context, index) {
              var item = provider.todoItems[index];
              if (provider.todoItems.isEmpty) {
                return const Center(child: Text("No data"));
              }
              return ListTile(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                title: provider.todoItems[index].isDone == true
                    ? Text(
                        item.task,
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.black,
                            decorationThickness: 2.0),
                      )
                    : Text(item.task),
                subtitle: provider.todoItems[index].isDone == true
                    ? Text(
                        item.description,
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.black,
                            decorationThickness: 2.0),
                      )
                    : Text(item.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditTodo(
                              task: item.task,
                              description: item.description,
                              ind: index,
                            ),
                          ));
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                      onPressed: () {
                        log("delete button presed");
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                elevation: 30,
                                // backgroundColor: Colors.grey,
                                title: const Center(child: Text("Delete Task")),
                                content: const Text(
                                  'Are Yout Sure You Want To Delete This Task',
                                ),
                                actions: [
                                  TextButton(
                                      child: const Text(
                                        'No',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                  TextButton(
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    onPressed: () {
                                      provider.deleteTodo(index);
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            });
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
                leading: Checkbox(
                  value: item.isDone ?? false,
                    onChanged: (value) {
                      provider.updateTodoCheckbox(index, value ?? false);
                    },
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          );
        },
      )),
    );
  }
}
