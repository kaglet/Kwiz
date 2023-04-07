import 'package:flutter/material.dart';
import 'package:kwiz/Models/quizzes.dart';
import 'package:kwiz/pages/home.dart';
import 'package:kwiz/start_quiz.dart';
import 'package:kwiz/services/database.dart';

class ViewQuizzes extends StatefulWidget {
  final String chosenCategory;
  const ViewQuizzes({super.key, required this.chosenCategory});

  @override
  // ignore: library_private_types_in_public_api
  _ViewQuizzesState createState() => _ViewQuizzesState();
}

class _ViewQuizzesState extends State<ViewQuizzes> {
  late String categoryName; // Declare the variable
  DatabaseService service = DatabaseService();
  List<Quiz>? categoryQuiz;
  List<Quiz>? filteredQuizzes;

  @override
  void initState() {
    super.initState();
    categoryName = widget.chosenCategory;
    loadData().then((value) {
      setState(() {});
    });
  }

  int catLength = 0;
  int filLength = 0;

  Future<void> loadData() async {
    if (categoryName == 'All') {
      categoryQuiz = await service.getAllQuizzes();
    } else {
      categoryQuiz = await service.getQuizByCategory(category: categoryName);
    }

    catLength = categoryQuiz!.length;
    filteredQuizzes = List<Quiz>.from(categoryQuiz!);
    filLength = filteredQuizzes!.length;
  }

  final TextEditingController _searchController = TextEditingController();

  void filterQuizzes(String searchTerm) {
    setState(() {
      filteredQuizzes = List<Quiz>.from(categoryQuiz!);
      List<String> quizzesNames = [];
      List<String> filteredQuizzesNames = [];

      for (int i = 0; i < catLength; i++) {
        quizzesNames.add(categoryQuiz!.elementAt(i).quizName);
      }

      filteredQuizzesNames = quizzesNames
          .where(
              (quiz) => quiz.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

      if (filteredQuizzesNames.isNotEmpty) {
        filteredQuizzes!.clear();
        for (int j = 0; j < filteredQuizzesNames.length; j++) {
          for (int k = 0; k < catLength; k++) {
            if (filteredQuizzesNames[j] ==
                categoryQuiz!.elementAt(k).quizName) {
              filteredQuizzes!.add(categoryQuiz!.elementAt(k));
            }
          }
        }
      } else {
        filteredQuizzes = List<Quiz>.from(categoryQuiz!);
      }

      filLength = filteredQuizzesNames.length;
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
                    filterQuizzes(_searchController.text);
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
                filterQuizzes(value);
              },
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/images/greypewds2.gif'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                filteredQuizzes == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: filLength,
                        itemBuilder: (context, index) {
                          final Color color1 = Colors.primaries[index % Colors.primaries.length];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              //color: const Color.fromARGB(255, 67, 162, 89),
                              color: color1,
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
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListTile(
                                title: Text(
                                  filteredQuizzes!.elementAt(index).quizName,
                                ),
                                textColor: Colors.white,
                                subtitle: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      const Text('Author: (TBA)'),
                                      const SizedBox(width: 8),
                                      Text(filteredQuizzes!
                                          .elementAt(index)
                                          .quizCategory),
                                      const SizedBox(width: 8),
                                      Text(filteredQuizzes!
                                          .elementAt(index)
                                          .quizDateCreated),
                                    ],
                                  ),
                                ),
                                trailing: ElevatedButton(
                        
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => StartQuiz(
                                            chosenQuiz: filteredQuizzes!
                                                .elementAt(index)
                                                .quizID),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: color1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text('Start Quiz'),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
