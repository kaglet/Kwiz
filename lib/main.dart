import 'package:flutter/material.dart';
import 'package:kwiz/quiz_screen.dart';
import 'package:kwiz/pages/home.dart';
import 'package:kwiz/pages/create_quiz.dart';

void main() => runApp(MaterialApp(
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
      home: AddQuiz(),
    ));
