// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class MultiLineTextField extends StatefulWidget {
  const MultiLineTextField({super.key});

  @override
  State<MultiLineTextField> createState() => _MultiLineTextFieldState();
}

class _MultiLineTextFieldState extends State<MultiLineTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: 4,
      maxLines: 5,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          hintText: '',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(5),
          ))),
    );
  }
}
