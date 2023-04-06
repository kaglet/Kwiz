// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:kwiz/classes/qa_obj.dart';
import 'package:kwiz/classes/qa_container.dart';
import 'package:kwiz/Models/questions.dart';
import 'package:kwiz/Models/quizzes.dart';
import 'package:kwiz/pages/home.dart';
import 'package:kwiz/pages/viewquizzes/view_quizzes.dart';
import 'package:kwiz/services/database.dart';

class AddQuestions extends StatefulWidget {
  final String category;
  final String title;
  final String aboutQuiz;

  const AddQuestions(
      {super.key,
      required this.aboutQuiz,
      required this.title,
      required this.category});

  @override
  State<AddQuestions> createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  List<QAContainer> qaContainers = [];
  List<Question> savedQAs = [];
  // DatabaseService service = DatabaseService();
  DatabaseService service = DatabaseService();
  int currentIndex = 0;

  bool _isLoading = false;

  Future<void> addData(Quiz quiz) async {
    setState(() {
      _isLoading = true;
    });
    await service.addQuizWithQuestions(quiz);
    setState(() {
      _isLoading = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ViewQuizzes(
                chosenCategory: 'All',
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isLoading
          ? null
          : AppBar(
              title: const Text(
                'Add Questions',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontFamily: 'TitanOne',
                ),
              ),
              backgroundColor: Color.fromARGB(255, 27, 57, 82),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: Implement category filter
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 27, 57, 82),
              Color.fromARGB(255, 5, 12, 31),
            ],
          ),
        ),
        child: SafeArea(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              //after data is loaded this displays
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  qaContainers.clear();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 230, 131, 44),
                                padding: const EdgeInsets.all(12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                              child: Text(
                                'Start over',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () async {
                                int i = 1;
                                for (var qaContainer in qaContainers) {
                                  QA qa = qaContainer.extractQA();

                                  Question questionObj = Question(
                                      questionNumber: i,
                                      questionText: qa.question,
                                      questionAnswer: qa.answer,
                                      questionMark: 0);
                                  savedQAs.add(questionObj);
                                  i++;
                                }
                                Quiz quiz = Quiz(
                                    quizName: widget.title,
                                    quizCategory: widget.category,
                                    quizDescription: widget.aboutQuiz,
                                    quizMark: 0,
                                    quizDateCreated: DateTime.now().toString(),
                                    quizQuestions: savedQAs,
                                    quizID: '');

                                addData(quiz);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 230, 131, 44),
                                padding: const EdgeInsets.all(12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  letterSpacing: 1.0,
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
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: qaContainers.length,
                          itemBuilder: (context, index) {
                            qaContainers.elementAt(index).number = index + 1;
                            return qaContainers.elementAt(index);
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                final uniqueKey = UniqueKey();
                                qaContainers.add(QAContainer(
                                    // when called it takes the parameter of key which is this widgets key
                                    // when called on the widget object it can pass its key with widget.key similar to this.key but for stateful objects
                                    delete: (key) {
                                      setState(() {
                                        qaContainers.removeWhere(
                                            (QAContainer) =>
                                                QAContainer.key == key);
                                      });
                                    },
                                    key: uniqueKey));
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 230, 131, 44),
                              padding: const EdgeInsets.all(12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                            child: Text(
                              'Add Question',
                              style: TextStyle(
                                fontSize: 15.0,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
