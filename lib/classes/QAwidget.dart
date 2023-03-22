import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
// ignore_for_file: prefer_const_constructors
import 'package:flutter/src/widgets/placeholder.dart';

class QAContainer extends StatelessWidget {
  // we can pass any input when instantiating the class so we can do this
  Function delete;
  QAContainer({required this.delete});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          color: Color.fromARGB(255, 233, 180, 75),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question:',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey[900],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    delete();
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          color: Color.fromARGB(255, 233, 180, 75),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Text(
              'Answer:',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey[900],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}
