import 'package:flutter/material.dart';
import 'package:kwiz/pages/viewquizzes/viewquizzes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Quizzes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(
          secondary: const Color.fromARGB(255, 138, 31, 156),
        ),
      ),

      home: ViewQuizzes(),
     
    );
  }
}

