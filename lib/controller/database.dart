import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:screltodo/model/mode.dart';

class DataBaseProvider with ChangeNotifier {
  ValueNotifier<List<TodoModel>> todoListNotifier = ValueNotifier([]);

  final TextEditingController taskcontroller = TextEditingController();
  final TextEditingController descripcontroller = TextEditingController();

  Future<void> addTodo(TodoModel model) async {
    final todoDatabase = await Hive.openBox<TodoModel>("todo");
    await todoDatabase.add(model);
    todoListNotifier.value.add(model);
    todoListNotifier.notifyListeners();
  }

  Future<void> getAllList() async {
    final todoDatabase = await Hive.openBox<TodoModel>("todo");
    todoListNotifier.value.clear();
    todoListNotifier.value.addAll(todoDatabase.values);
    todoListNotifier.notifyListeners();
  }

  Future<void> deleteStudent(index) async {
    final todoDatabase = await Hive.openBox<TodoModel>("todo");
    todoDatabase.deleteAt(index);
    getAllList();
  }

  Future<void> editList(int id, TodoModel value) async {
    final todoDatabase = await Hive.openBox<TodoModel>('student_db');
    todoDatabase.putAt(id, value);
    getAllList();
  }

  clearController() {
    taskcontroller.clear();
    descripcontroller.clear();
  }
}
