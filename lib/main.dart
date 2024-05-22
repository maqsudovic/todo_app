import 'package:flutter/material.dart';
import 'package:todo_app/views/todo_view.dart';

void main(List<String> args) {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlanWidget(),
    );
  }
}
