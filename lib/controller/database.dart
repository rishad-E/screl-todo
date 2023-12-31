import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:screltodo/model/mode.dart';

class DataBaseProvider with ChangeNotifier {
  final TextEditingController taskcontroller = TextEditingController();
  final TextEditingController descripcontroller = TextEditingController();
  List<TodoModel> _todoItems = [];
  bool isloading = false;
  List<TodoModel> get todoItems => _todoItems;

  Future<void> addTodoItem(TodoModel model) async {
    final todoDatabase = await Hive.openBox<TodoModel>("to-do");
    todoDatabase.add(model);
    getAllTodo();
    notifyListeners();
  }

  Future<void> getAllTodo() async {
    final todoDatabase = await Hive.openBox<TodoModel>("to-do");
    _todoItems = todoDatabase.values.toList();
    notifyListeners();
  }

  Future<void> deleteTodo(index) async {
    final todoDatabase = await Hive.openBox<TodoModel>("to-do");
    todoDatabase.deleteAt(index);
    notifyListeners();
    getAllTodo();
    log('todo item deleted');
  }

  Future<void> editTodo(int index, TodoModel model) async {
    final todoDatabase = await Hive.openBox<TodoModel>("to-do");
    todoDatabase.putAt(index, model);
    getAllTodo();
    notifyListeners();
  }

  Future<void> updateTodoCheckbox(int index, bool isDone) async {
    final todoDatabase = await Hive.openBox<TodoModel>("to-do");
    final todo = todoDatabase.getAt(index);
    if (todo != null) {
      todo.isDone = isDone;
      todoDatabase.putAt(index, todo);
      getAllTodo();
      notifyListeners();
    }else{
      log('Todo not found at index $index',name: 'update todo check');
      throw Exception("could not find a todo index");
      
    }
  }

  clearController() {
    taskcontroller.clear();
    descripcontroller.clear();
  }

  String? validation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter this field';
    } else {
      return null;
    }
  }
}
