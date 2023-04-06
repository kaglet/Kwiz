import 'package:flutter/material.dart';
import 'package:kwiz/pages/add_quiz_about.dart';
import 'package:kwiz/pages/profile.dart';
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
      // appBar: AppBar(
      //   title: const Text('Home'),
      //   actions: [
      // IconButton(
      //   icon: const Icon(Icons.person),
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const Home()),
      //     );
      //   },
      // ),
      //   ],
      // ),
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ignore: prefer_const_literals_to_create_immutables
              Row(children: <Widget>[
                const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Profile()),
                    );
                  },
                ),
              ]),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 70.0,
                child: Text(
                  'Good Morning, Kago',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Divider(
                height: 20.0,
                color: Colors.white,
              ),
              Center(
                child: Text(
                  'What would you like to do?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 150.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewCategories()),
                          );
                        },
                        child: const Card(
                          color: Colors.redAccent,
                          child: Center(
                            child: Text(
                              'Browse our quizzes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 150.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddQuiz()),
                          );
                        },
                        child: const Card(
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              'Add custom quiz',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         new MaterialPageRoute(
              //             builder: (context) => new AddQuiz()));
              //   },
              // style: ElevatedButton.styleFrom(
              //   padding: const EdgeInsets.all(12.0),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(12), // <-- Radius
              //   ),
              //   ),
              //   child: const Text(
              //     'Add custom quiz',
              //     style: TextStyle(
              //       fontSize: 17.0,
              //       letterSpacing: 1.0,
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
