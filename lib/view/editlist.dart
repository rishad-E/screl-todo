import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screltodo/controller/database.dart';
import 'package:screltodo/utils/widget.dart';

class EditTodo extends StatelessWidget {
   EditTodo({super.key, required this.task, required this.description,required this.index});

  final String task;
  final String description;
  final int index;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataBaseProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SizedBox(
              height: 300,
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      decoration: decoration(),
                      controller: provider.taskcontroller,
                    ),
                    TextFormField(
                      
                      decoration: decoration(),
                      controller: provider.descripcontroller,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              onEditbutton();
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(fontSize: 22),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void>onEditbutton()async{
   
  }
}
