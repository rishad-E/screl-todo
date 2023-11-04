import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screltodo/controller/database.dart';
import 'package:screltodo/model/mode.dart';
import 'package:screltodo/view/editlist.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<DataBaseProvider>(
          builder: (context, value, child) {
            return ValueListenableBuilder(
              valueListenable: value.todoListNotifier,
              builder: (context, List<TodoModel> todo, child) {
                if (todo.isEmpty) {
                  return const Center(
                    child: Text("No Data added"),
                  );
                } else {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        final data = todo[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditTodo(
                                  index: index,
                                    task: data.task,
                                    description: data.description)));
                          },
                          child: ListTile(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              leading:
                                  Checkbox(value: true, onChanged: (value) {}),
                              title: Text(
                                data.task,
                              ),
                              subtitle: Text(data.description),
                              trailing: IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0)),
                                            elevation: 30,
                                            // backgroundColor: Colors.grey,
                                            title: const Center(
                                                child: Text("Delete Task")),
                                            content: const Text(
                                              'Are Yout Sure You Want To Delete This Task',
                                            ),
                                            actions: [
                                              TextButton(
                                                  child: const Text(
                                                    'No',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }),
                                              TextButton(
                                                child: const Text(
                                                  'Yes',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                onPressed: () {
                                                  // deleteStudent(index);
                                                  value.deleteStudent(index);
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(Icons.delete))),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 5),
                      itemCount: todo.length);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
