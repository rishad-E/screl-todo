import 'package:hive_flutter/hive_flutter.dart';
part 'mode.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  final String task;
  @HiveField(1)
  final String description;


  TodoModel({
    required this.task,
    required this.description,
  });
}
