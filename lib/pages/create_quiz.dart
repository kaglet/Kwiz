// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kwiz/classes/QA.dart';
import 'package:kwiz/classes/QAwidget.dart';
import 'package:kwiz/classes/aboutCard.dart';
import 'package:kwiz/classes/multiLineTextField.dart';
import 'package:kwiz/pages/addQuestions.dart';
import 'package:kwiz/pages/home.dart';
import 'package:kwiz/services/database.dart';

class AddQuiz extends StatefulWidget {
  final _aboutQuizController = TextEditingController();
  final _categoryController = TextEditingController();
  final _titleController = TextEditingController();

  AddQuiz({super.key});
  @override
  State<AddQuiz> createState() => AddQuizState();
}

class AddQuizState extends State<AddQuiz> {
  List<QAContainer> QAContainers = [];
  List? categories = [];
  DatabaseService service = DatabaseService();

  Future<void> loaddata() async {
    categories = await service.getCategories();
    print(categories);
  }

  @override
  void initState() {
    super.initState();
    loaddata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Quizzes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    print(categories);
                  },
                  child: Text('')),
              SizedBox(
                height: 20.0,
              ),
              Card(
                color: Colors.transparent,
                margin: EdgeInsets.fromLTRB(10.0, 16.0, 16.0, 0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextField(
                        controller: widget._titleController,
                        decoration: InputDecoration(
                          hintText: 'Add Title',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: widget._aboutQuizController,
                        minLines: 5,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelText: 'About',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            hintText: 'About',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ))),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      TextField(
                        controller: widget._categoryController,
                        decoration: InputDecoration(
                          hintText: 'Category',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 10.0,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 60.0,
                color: Color.fromARGB(255, 8, 8, 8),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddQuestions(
                            aboutQuiz: widget._aboutQuizController.text,
                            category: widget._categoryController.text,
                            title: widget._titleController.text)),
                  );
                },
                style: ButtonStyle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Begin adding questions',
                      style: TextStyle(
                        fontSize: 15.0,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class MyButton extends StatelessWidget {
//   const MyButton({super.key});

//   MyButton({required this.color, this.text});
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// create custom button class since all have the same property
// Think in terms of flexbox don't forget everything there. The space works very well with flex properties, to make empty space in a container when padding is too hard.
// spacing is also very customizable.
