import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
// ignore_for_file: prefer_const_constructors
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kwiz/classes/multiLineTextField.dart';

class QAContainer extends StatefulWidget {
  // we can pass any input when instantiating the class so we can do this
  Function delete;
  final Key? key;
  // make private index variable, for index of widget in parent list
  int? number;

  QAContainer({required this.delete, required this.key, int? number})
      : super(key: key) {
    // set the optional parameter if no value is provided
    this.number = number ?? 0;
  }

  @override
  State<QAContainer> createState() => _QAContainerState();
}

class _QAContainerState extends State<QAContainer> {
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: [
              Spacer(),
              IconButton(
                onPressed: () {
                  /* calls widget.delete for this widget. It's like using this.delete and this.key except that changes for stateful widgets. */
                  widget.delete(widget.key);
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
          Container(
            color: Colors.white,
            child: SizedBox(
              height: 100,
              child: MultiLineTextField(
                minLines: 3,
                maxLines: 3,
                hintText: 'Question ${widget.number}',
                labelText: 'Question ${widget.number}',
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.white,
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Flexible(
                  child: MultiLineTextField(
                    minLines: 1,
                    maxLines: 1,
                    hintText: 'Answer',
                    labelText: 'Answer',
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}
