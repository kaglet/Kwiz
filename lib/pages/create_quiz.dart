// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:kwiz/classes/QA.dart';
import 'package:kwiz/classes/QAwidget.dart';
import 'package:kwiz/classes/aboutCard.dart';
import 'package:kwiz/classes/multiLineTextField.dart';

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
      backgroundColor: Color.fromARGB(255, 249, 235, 237),
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
                height: 20.0,
                color: Color.fromARGB(255, 8, 8, 8),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: 100.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          QAContainers.clear();
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red.shade400),
                      ),
                      child: Text(
                        'Start over',
                        style: TextStyle(
                          fontSize: 15.0,
                          letterSpacing: 1.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red.shade400),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 15.0,
                          letterSpacing: 1.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: QAContainers.length,
                    itemBuilder: (context, index) {
                      QAContainers.elementAt(index).number = index + 1;
                      return QAContainers.elementAt(index);
                    },
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        final uniqueKey = UniqueKey();
                        QAContainers.add(QAContainer(
                            // when called it takes the parameter of key which is this widgets key
                            // when called on the widget object it can pass its key with widget.key similar to this.key but for stateful objects
                            delete: (key) {
                              setState(() {
                                QAContainers.removeWhere(
                                    (QAContainer) => QAContainer.key == key);
                              });
                            },
                            key: uniqueKey));
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red.shade400),
                    ),
                    child: Text(
                      'Add Question',
                      style: TextStyle(
                        fontSize: 15.0,
                        letterSpacing: 1.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
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
