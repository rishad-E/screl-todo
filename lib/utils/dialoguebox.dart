// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:screltodo/utils/alertbutton.dart';

class DialogBox extends StatelessWidget {
  final taskcontroller;
  final descriptcontroller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {super.key,
      required this.taskcontroller,
      required this.descriptcontroller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: Colors.green,
      content: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: taskcontroller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'new task'),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: descriptcontroller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'task description'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AlertButton(
                  text: "save",
                  onPressed: onSave,
                ),
                const SizedBox(
                  width: 15,
                ),
                AlertButton(
                  text: "cancel",
                  onPressed: onCancel,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
