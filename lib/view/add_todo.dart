import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screltodo/controller/database.dart';
import 'package:screltodo/model/mode.dart';
import 'package:screltodo/utils/widget.dart';

class AddTodoItem extends StatelessWidget {
  AddTodoItem({super.key});

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        title: const Text(
          "Add TODO",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
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
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          decoration: decoration(hint: 'Enter Task'),
                          controller: provider.taskcontroller,
                          validator: (value) => provider.validation(value),
                        ),
                        TextFormField(
                          decoration: decoration(hint: 'Enter Description'),
                          controller: provider.descripcontroller,
                          validator: (value) => provider.validation(value),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  log('${provider.taskcontroller.text} ${provider.descripcontroller.text}');
                                  provider
                                      .addTodoItem(TodoModel( 
                                          task: provider.taskcontroller.text,
                                          description:
                                              provider.descripcontroller.text))
                                      .then((value) => {
                                            Navigator.of(context).pop(),
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  margin: EdgeInsets.all(20),
                                                  content: Text(
                                                      "Task Added Sucessfully.. ")),
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
