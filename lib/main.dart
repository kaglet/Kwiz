import 'package:flutter/material.dart';
import 'package:kwiz/pages/home.dart';
import 'package:kwiz/pages/create_quiz.dart';
import 'package:kwiz/pages/viewquizzes/viewquizzes.dart';
import 'package:kwiz/quiz_screen.dart';
import 'package:kwiz/start_quiz.dart';
import 'package:kwiz/view_categories.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(
                secondary: const Color.fromARGB(
                    255, 138, 31, 156)), // Set the accent color to purple
      ),
      home: Home(),
    ));
