import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kwiz/firebase_options.dart';
import 'package:kwiz/pages/viewquizzes/viewquizzes.dart';
import 'package:kwiz/quiz_screen.dart';
import 'package:kwiz/services/database.dart';
import 'package:kwiz/Models/Quizzes.dart';

//void main() => runApp(const StartQuiz());

class StartQuiz extends StatefulWidget {
  // const StartQuiz({super.key});
  final String chosenQuiz;
  const StartQuiz({required this.chosenQuiz});
  @override
  _StartQuizState createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  late String info = '';
  String image = 'Sport.gif';
  late String category = '';
  late String title = '';
  late String dateCreated = '';
  late String QuizID = widget.chosenQuiz; // Declare the variable
  //QuizID = widget.chosenQuiz;
  DatabaseService service = DatabaseService();

  Future<void> loaddata() async {
    Quiz? details;
    details = await service.getQuizInformationOnly(QuizID: QuizID);
    title = details!.QuizName;
    info = details.QuizDescription;
    category = details.QuizCategory;
    dateCreated = details.QuizDateCreated;
  }

  void initState() {
    super.initState();
    loaddata().then((value) {
      setState(() {});
      //QuizID = widget.chosenQuiz;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 5, left: 5, top: 20),
          child: Container(
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
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewQuizzes(
                                    chosenCategory: category,
                                  )),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 24,
                      ),
                      label: const Text(
                        'Quizzes',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.underline),
                    )
                  ],
                ),
                SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          height: 500,
                          child: Image.asset(
                              'assets/images/' +
                                  category +
                                  '.gif', //This loads the gif repective to the quiz's category
                              height: 500,
                              width: 500,
                              scale: 0.5,
                              opacity: const AlwaysStoppedAnimation<double>(1)),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(width: 2 /*color: Colors.white*/),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.only(
                              right: 15, left: 15, bottom: 10, top: 10),
                          height: 250,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                ),
                                RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      text: info,
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black),
                                    )),
                                RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      text: 'Category: ' + category,
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black),
                                    )),
                                RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      text: 'Date Created: ' + dateCreated,
                                      style: TextStyle(
                                          fontSize: 26,
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QuizScreen()),
                                      );
                                    },
                                  ),
                                  // onPressed: () {
                                  //   // TODO: Implement start quiz button action
                                  //   // Navigator.push(
                                  //   //   context,
                                  //   //   MaterialPageRoute(
                                  //   //       builder: (context) => QuizScreen()),
                                  //   // );
                                  // },
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
