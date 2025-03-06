import 'package:flutter/material.dart';
import 'package:sq_lite_todo_app/home/ui/screens/home_screen.dart';

class SqTodoApp extends StatelessWidget {
  const SqTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
