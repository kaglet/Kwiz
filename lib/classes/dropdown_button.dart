import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  final List<dynamic> options;
  final String initialValue;
  final ValueChanged<String> onChanged;

  MyDropdownButton({
    Key? key,
    required this.options,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: _selectedValue,
      items: widget.options.map((option) {
        return DropdownMenuItem(
          value: option.toString(),
          child: Text(option.toString()),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedValue = newValue as String?;
        });
        widget.onChanged(newValue as String);
      },
    );
  }
}
