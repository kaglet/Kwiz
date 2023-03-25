import 'package:flutter/material.dart';
import 'package:kwiz/main.dart';

class ViewQuizzes extends StatefulWidget {
  const ViewQuizzes({Key? key}) : super(key: key);

  @override
  _ViewQuizzesState createState() => _ViewQuizzesState();
}

class _ViewQuizzesState extends State<ViewQuizzes> {
  final List<String> categories = [
    'Science',
    'Math',
    'History',
    'Geography',
    'Literature',
    'Rizzology'
  ];
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
  void initState() {
    super.initState();
    filteredQuizzes = quizzes;
  }

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
            // TODO: Implement category filter
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search quizzes',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _filterQuizzes(_searchController.text);
                  },
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
                      color: Color.fromARGB(255, 181, 40, 216),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Set the radius of the border corners
                      ),
                      child: ListTile(
                        title: Text(filteredQuizzes[index]),
                        subtitle: Row(
                          children: [
                            Text('Author: '),
                            Text('Category: '),
                            Text('No Quest: '),
                            Text('Time:'),
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement start quiz button action
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