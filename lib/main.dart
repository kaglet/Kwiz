<<<<<<< HEAD
// import 'dart:js';

import 'package:flutter/material.dart';
=======
import 'package:kwiz/quiz_screen.dart';
>>>>>>> 177c6e4e8ad063a18aff3ac948b6fd5d87068f93
import 'package:kwiz/pages/home.dart';
import 'package:kwiz/pages/create_quiz.dart';
import 'package:kwiz/pages/loading.dart';

void main() => runApp(MaterialApp(
<<<<<<< HEAD
      home: Home(),
=======
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
>>>>>>> 177c6e4e8ad063a18aff3ac948b6fd5d87068f93
    ));
