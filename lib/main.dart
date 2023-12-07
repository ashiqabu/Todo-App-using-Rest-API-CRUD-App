import 'package:api_data_from_swagger/screens/to_do_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const TodoList(),
      routes: <String, WidgetBuilder>{
        'todolist/': (BuildContext context) => const TodoList(),
        
      },
    );
  }
}
