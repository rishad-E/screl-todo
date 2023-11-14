import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screltodo/controller/database.dart';
import 'package:screltodo/model/mode.dart';
import 'package:screltodo/utils/widget.dart';

class EditTodo extends StatelessWidget {
  final String task;
  final String description;
  final int ind;
  EditTodo(
      {super.key,
      required this.task,
      required this.description,
      required this.ind});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SizedBox(
              height: 300,
              width: double.infinity,
              child: Consumer<DataBaseProvider>(
                builder: (context, provider, child) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          decoration: decoration(),
                          controller: provider.taskcontroller..text = task,
                          validator: (value) => provider.validation(value),
                        ),
                        TextFormField(
                          decoration: decoration(),
                          controller: provider.descripcontroller
                            ..text = description,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  log("${provider.taskcontroller.text} ${provider.descripcontroller.text} $ind");
                                  provider
                                      .editTodo(
                                          ind,
                                          TodoModel(
                                            task: provider.taskcontroller.text,
                                            description:
                                                provider.descripcontroller.text,
                                            isDone: false,
                                          ))
                                      .then((value) => {
                                            Navigator.of(context).pop(),
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  margin: EdgeInsets.all(20),
                                                  content: Text(
                                                      "Task Edited Sucessfully.. ")),
                                            ),
                                            provider.clearController()
                                          });
                                }
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(fontSize: 22),
                              )),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
