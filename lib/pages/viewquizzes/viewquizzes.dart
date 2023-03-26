import 'package:flutter/material.dart';
import 'package:kwiz/Models/Quizzes.dart';
import 'package:kwiz/main.dart';
import 'package:kwiz/pages/home.dart';
import 'package:kwiz/start_quiz.dart';
import 'package:kwiz/firebase_options.dart';
import 'package:kwiz/services/database.dart';

class ViewQuizzes extends StatefulWidget {
  final String chosenCategory;

  const ViewQuizzes({required this.chosenCategory});

  // const ViewQuizzes({Key? key}) : super(key: key);

  @override
  _ViewQuizzesState createState() => _ViewQuizzesState();
}

DatabaseService service = DatabaseService();

Future<Quiz?>  loaddata() async{
   Quiz? quiz = await service.getQuizAndQuestions(QuizID: '5P9Hxbv8r7424vFfjcWG');
    return quiz;
}

class _ViewQuizzesState extends State<ViewQuizzes> {
  late String categoryName; // Declare the variable

  @override
  void initState() {
    super.initState();
    categoryName = widget
        .chosenCategory; // Initialize the variable with the passed category value
    filteredQuizzes = quizzes;
  }
  

  List<String> quizzes = [
    'Quiz 1',
    'Quiz 2',
    'Quiz 3',
    'Quiz 4',
    'Quiz 5',
    'Quiz 6',
    'Quiz 7',
    'Quiz 8',
  ];
  List<String> filteredQuizzes = [];

  final TextEditingController _searchController = TextEditingController();

  final int _numberOfQuizzesToAdd = 5;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterQuizzes(String searchTerm) {
    setState(() {
      filteredQuizzes = quizzes
          .where(
              (quiz) => quiz.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  void _loadMoreQuizzes() {
    setState(() {
      for (int i = 1; i <= _numberOfQuizzesToAdd; i++) {
        quizzes.add('Quiz ${quizzes.length + 1}');
      }
      filteredQuizzes = quizzes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Quizzes'),
        leading: IconButton(
          icon: const Icon(Icons.category),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(
                color: Colors.white, // set the text color to white
              ),
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(53, 62, 57, 1), // set the background color to a darker grey
                hintText: 'Search quizzes',
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(192, 192, 192,1), // set the hint text color to a light grey
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  color: const Color.fromRGBO(192, 192, 192,1), // set the search icon color to a light grey
                  onPressed: () {
                    _filterQuizzes(_searchController.text);
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(81, 95, 87,1)), // set the border color to a darker grey
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors
                          .white), // set the focused border color to white
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onChanged: (value) {
                _filterQuizzes(value);
              },
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollEndNotification &&
                    scrollNotification.metrics.extentAfter == 0) {
                  _loadMoreQuizzes();
                }
                return true;
              },
              child: ListView.builder(
                itemCount: filteredQuizzes.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 67, 162, 89),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3.0,
                          spreadRadius: 2.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Card(
                      color: const Color.fromARGB(255, 68, 80, 74),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Set the radius of the border corners
                      ),
                      child: ListTile(
                        title: Text(filteredQuizzes[index]),
                        textColor: Colors.white,
                        subtitle: Row(
                          children: [
                            const Text('Author: '),
                            Text('$categoryName'),
                            const Text('No Quest: '),
                            const Text('Time:'),
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement start quiz button action
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const StartQuiz()),
                            );
                          },
                          child: const Text('Start Quiz'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Set the radius of the border corners
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
