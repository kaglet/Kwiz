import 'package:flutter/foundation.dart';
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

  @override
  _ViewQuizzesState createState() => _ViewQuizzesState();
}

class _ViewQuizzesState extends State<ViewQuizzes> {
  late String categoryName; // Declare the variable
  DatabaseService service = DatabaseService();
  List<Quiz>? CategoryQuiz;
  List<Quiz>? filteredQuizzes;

  @override
  void initState() {

  super.initState();
  categoryName = widget.chosenCategory;
  loaddata().then((value) {
    setState(() {});
  });
}

  int CatLength = 0;
  int FilLength = 0;

  Future<void> loaddata() async {
    CategoryQuiz = await service.getQuizByCategory(Category: categoryName);
    CatLength = CategoryQuiz!.length;
    filteredQuizzes = List<Quiz>.from(CategoryQuiz!);
    FilLength = filteredQuizzes!.length;
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  void _filterQuizzes(String searchTerm) {
    setState(() {
      filteredQuizzes = List<Quiz>.from(CategoryQuiz!);
      List<String> quizzesNames = [];
      List<String> filteredQuizzesNames = [];

      for (int i = 0; i < CatLength; i++) {
        quizzesNames.add(CategoryQuiz!.elementAt(i).QuizName);
      }

      filteredQuizzesNames = quizzesNames
          .where(
              (quiz) => quiz.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

      if (filteredQuizzesNames.length != 0) {
        filteredQuizzes!.clear();
        for (int j = 0; j < filteredQuizzesNames.length; j++) {
          for (int k = 0; k < CatLength; k++) {
            if (filteredQuizzesNames[j] == CategoryQuiz!.elementAt(k).QuizName) {
              filteredQuizzes!.add(CategoryQuiz!.elementAt(k));
            }
          }
        }
      } else {
        filteredQuizzes = List<Quiz>.from(CategoryQuiz!);
      }

      FilLength = filteredQuizzesNames.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(filteredQuizzes!.elementAt(0).QuizName);
    // print(CategoryQuiz!.elementAt(0).QuizCategory);
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
                fillColor: const Color.fromRGBO(
                    53, 62, 57, 1), // set the background color to a darker grey
                hintText: 'Search quizzes',
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(192, 192, 192,
                      1), // set the hint text color to a light grey
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  color: const Color.fromRGBO(192, 192, 192,
                      1), // set the search icon color to a light grey
                  onPressed: () {
                    _filterQuizzes(_searchController.text);
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(81, 95, 87,
                          1)), // set the border color to a darker grey
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
            child: filteredQuizzes == null
                ? const Center(
                    child:
                        CircularProgressIndicator()) // Display a loading indicator if filteredQuizzes is null
                : ListView.builder(
                    itemCount: FilLength,
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
                            title:
                                Text(filteredQuizzes!.elementAt(index).QuizName),
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
                    }, //ItemBuilder
                  ),
          ),
        ],
      ),
    );
  }
}
