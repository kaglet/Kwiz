import 'package:flutter/material.dart';
import 'package:kwiz/quiz_screen.dart';


class wrapper extends StatelessWidget {
  const wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //return home or taking quiz
    return QuizScreen();
  }
}