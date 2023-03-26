// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class MultiLineTextField extends StatefulWidget {
  final int minLines;
  final int maxLines;
  final String hintText;
  final String labelText;
  const MultiLineTextField(
      {Key? key,
      required this.minLines,
      required this.maxLines,
      required this.hintText,
      required this.labelText})
      : super(key: key);

  @override
  State<MultiLineTextField> createState() => _MultiLineTextFieldState();
}

class _MultiLineTextFieldState extends State<MultiLineTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          hintText: widget.hintText,
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
