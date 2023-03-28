// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:kwiz/pages/create_quiz.dart';
import 'package:kwiz/view_categories.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3, color: Colors.black),
                          shape: BoxShape.rectangle,
                        ),
                        height: 100.0,
                        width: 250.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 0.0,
                            child: Text(
                              'Good Morning, Kago',
                              style: TextStyle(
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.black),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.person,
                        size: 40.0,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 100.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewCategories()),
                      );*/
                    },
                    child: Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new AddQuiz()));
                },
                style: ButtonStyle(),
                child: Text(
                  'Add Quiz',
                  style: TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 1.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
