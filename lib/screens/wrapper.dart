import 'package:flutter/material.dart';
import 'package:kwiz/screens/takingquiz.dart';


class wrapper extends StatelessWidget {
  const wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //return home or taking quiz
    return takingquiz();
  }
}