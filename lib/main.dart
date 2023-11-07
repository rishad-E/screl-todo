import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:screltodo/controller/database.dart';
import 'package:screltodo/model/mode.dart';
import 'package:screltodo/view/homescreen.dart';

void main() async{
  //initializing hive
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(TodoModelAdapter().typeId)) {
    Hive.registerAdapter(TodoModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => DataBaseProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home:  const HomeScreen(),
      ),
    );
  }
}
