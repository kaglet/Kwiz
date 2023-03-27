import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kwiz/quiz_screen.dart';

void main() => runApp(const StartQuiz());

class StartQuiz extends StatelessWidget {
  const StartQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(colorSchemeSeed: Colors.black),
        home: const StartQuizScreen());
  }
}

class StartQuizScreen extends StatefulWidget {
  const StartQuizScreen({super.key});

  @override
  State<StartQuizScreen> createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuizScreen> {
  //Golabal variables can be declared here
  String image = 'rocket.gif';
  String title = 'Space Quiz'; //To be replaced by database query
  String info =
      'For years it was believed that Earth was the only planet in our solar system with liquid water. More recently, NASA revealed its strongest evidence yet that there is intermittent running water on Mars, too!'; //To be replaced by database query
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(right: 5, left: 5, top: 18.0),
        //padding: const EdgeInsets.fromLTRB(5,18,5,0) ,
        child: Container(
          height: 1100,
          width: 500,
          child: Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        side: BorderSide(width: 1.5, color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 28,
                      ),
                      label: const Text(
                        'Quizzes',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      'Space Quiz',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
                //Spacer(),
                Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // Container(
                      //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      //   height: 500,
                      //   child: Image.asset('assets/images/' + image,
                      //       height: 100,
                      //       width: 400,
                      //       scale: 0.5,
                      //       opacity: const AlwaysStoppedAnimation<double>(1)),
                            
                      // ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 2 /*color: Colors.white*/),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(
                            right: 15, left: 15, bottom: 10, top: 10),
                        height: 300,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              RichText(
                                  text: TextSpan(
                                text: info,
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              )),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  child: Text('Start'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal),
                                  ),
                                  onPressed: () {
                                    // TODO: Implement start quiz button action
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => QuizScreen()),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
