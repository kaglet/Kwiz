// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:kwiz/classes/QA.dart';
import 'package:kwiz/classes/QAwidget.dart';
import 'package:kwiz/classes/aboutCard.dart';
import 'package:kwiz/classes/multiLineTextField.dart';
import 'package:kwiz/pages/addQuestions.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key});

  @override
  State<AddQuiz> createState() => AddQuizState();
}

class AddQuizState extends State<AddQuiz> {
  List<QAContainer> QAContainers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.home,
                      color: Colors.black,
                      size: 20.0,
                    ),
                    label: Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.0,
                        fontSize: 15.0,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red.shade400),
                    ),
                  ),
                ],
              ),
              aboutQuizCard(),
              Divider(
                height: 60.0,
                color: Color.fromARGB(255, 8, 8, 8),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddQuestions()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.red.shade400),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Begin adding questions',
                      style: TextStyle(
                        fontSize: 15.0,
                        letterSpacing: 1.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class MyButton extends StatelessWidget {
//   const MyButton({super.key});

//   MyButton({required this.color, this.text});
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// create custom button class since all have the same property
// Think in terms of flexbox don't forget everything there. The space works very well with flex properties, to make empty space in a container when padding is too hard.
// spacing is also very customizable.
