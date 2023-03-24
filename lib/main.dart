import 'package:flutter/material.dart';
import 'package:kwiz/quiz_screen.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Color.fromARGB(255, 49, 49, 49),
        textTheme: TextTheme(
          headline1: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          headline2: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          bodyText2: TextStyle(color: Color.fromARGB(255, 238, 238, 238)),
          subtitle1: TextStyle(color: Color.fromARGB(255, 157, 199, 123)),
        )
      ),
      home: QuizScreen(),
    );
  }
}

