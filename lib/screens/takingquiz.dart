import "package:flutter/material.dart";

class takingquiz extends StatefulWidget {
  const takingquiz({super.key});

  @override
  State<takingquiz> createState() => _takingquizState();
}

class _takingquizState extends State<takingquiz> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            // bottom: const TabBar(
            //   tabs: [
            //     Tab(icon: Icon(Icons.menu)),
            //   ],
            // ),
            title: const Text('Quiz 1'), //name of quiz
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text('Question 1',
                  style: TextStyle(fontSize: 20))),

              Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                  color: Colors.blue[50],
                  child: const Align(
                    alignment: FractionalOffset(0.2, 0.6),
                    child: Text('In “Harry Potter and the Sorcerer’s Stone,” what keeps the three-headed dog asleep?',
                      style: TextStyle(fontSize: 17), ),
                    ),
                  ),
                ),
            ],
            )
          ),
        ),
      );
  }
}