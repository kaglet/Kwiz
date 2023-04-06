import 'package:flutter/material.dart';
import 'package:kwiz/pages/viewquizzes/view_quizzes.dart';
import 'package:kwiz/take_quiz.dart';
import 'package:kwiz/services/database.dart';
import 'package:kwiz/Models/quizzes.dart';

class StartQuiz extends StatefulWidget {
  final String chosenQuiz;
  const StartQuiz({super.key, required this.chosenQuiz});
  @override
  _StartQuizState createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  late String info = '';
  late String category = '';
  late String title = '';
  late String dateCreated = '';
  String date = '';
  late String quizID = widget.chosenQuiz;
  bool _isLoading = true;
  DatabaseService service = DatabaseService();

  Future<void> loaddata() async {
    Quiz? details;
    details = await service.getQuizInformationOnly(quizID: quizID);
    title = details!.quizName;
    info = details.quizDescription;
    category = details.quizCategory;
    dateCreated = details.quizDateCreated;
    date =  dateCreated.substring(0, 10);
  }

  @override
  void initState() {
    super.initState();
    _startLoading();
    loaddata().then((value) {
      setState(() {});
    });
  }

  void _startLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(41,41,52,1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 5, left: 5, top: 20),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                 Row(
                children: [
                  IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 40.0,
                              ),
                              onPressed: () {
                                Navigator.pop(context,
                                MaterialPageRoute(
                                    builder: (context) => ViewQuizzes(chosenCategory: category,)),);
                              },
                            ),
                ],
                ),
                        Padding(
                              padding: const EdgeInsets.fromLTRB(0,8,0,0),
                              child: Text(title,
                                       style: const TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold ),
                                       textAlign: TextAlign.start,
                                     ),
                            ),
                SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Center(
                            child: _isLoading? const CircularProgressIndicator(): Image.asset(
                                    'assets/images/$category.gif', //This loads the gif repective to the quiz's category
                                    height: 500,
                                    width: 500,
                                    scale: 0.5,
                                    opacity:
                                        const AlwaysStoppedAnimation<double>(1)),
                                                    ),
                         /* Positioned(
                            top: 48,
                            left: 0,
                            child: Container(
                                    //height: 50,
                                    //width: 120,
                                    child: Text(
                                      category,
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
                                    ),
                                    decoration: BoxDecoration(
                                      
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.red,
                                          Colors.pink,
                                        ],
                                      ),
                                    ),
                                  ),
                          )*/
                                            ]),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(width: 2 /*color: Colors.white*/),
                            color: const Color.fromRGBO(97,100,115,1),
                          ),
                          padding: const EdgeInsets.only(
                              right: 15, left: 15, bottom: 10, top: 10),
                          //height: 250,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,5,0,0),
                                  child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        text: info,
                                        style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      )),
                                ),
                                RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      text: 'Date Created: $date',
                                      style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    )),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromRGBO(41,41,52,1),
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
                                            builder: (context) =>
                                                QuizScreen(quizID)),
                                      );
                                    },
                                    child: const Text('Start'),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              QuizScreen(quizID)),
                                    );
                                  },
                                  child: const Text('Start'),
                                ),
                                
                              ],
                            ),
                          ),
                        ),
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
