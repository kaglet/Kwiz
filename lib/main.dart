import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kwiz/Models/Questions.dart';
import 'package:kwiz/Models/Quizzes.dart';
import 'package:kwiz/firebase_options.dart';
import 'package:kwiz/services/database.dart';
import 'package:provider/provider.dart';
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StreamSubscription sub;
  late Map data;
  //Calling the Database service class to use database functions
  DatabaseService service = DatabaseService();
  List<Quiz> listQuizzes = [];

  late List<Question> Questions = [];

  @override
  void initState() {
    sub = service.quizCollection.snapshots().listen((snap) {
      setState(() {
        for (var docSnapshot in snap!.docs) {
          Quiz quiz = Quiz(
              QuizName: docSnapshot['QuizName'],
              QuizCategory: docSnapshot['QuizCategory'],
              QuizDescription: docSnapshot['QuizDescription'],
              QuizMark: 0,
              QuizDateCreated: docSnapshot['QuizDateCreated'],
              QuizQuestions: Questions,
              QuizID: docSnapshot.id);
          listQuizzes.add(quiz);
        }
      });
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //add quiz with list of questions
            TextButton(
              onPressed: () async {
                late List<Question> questions = [];
                Question q1 = Question(
                    QuestionNumber: 1,
                    QuestionText: 'Question 1 Michael',
                    QuestionAnswer: 'Question 1000 Answer',
                    QuestionMark: 1);
                Question q2 = Question(
                    QuestionNumber: 2,
                    QuestionText: 'Question 20000',
                    QuestionAnswer: 'Question 20000 Answer',
                    QuestionMark: 1);
                Question q3 = Question(
                    QuestionNumber: 3,
                    QuestionText: 'Question 3000',
                    QuestionAnswer: 'Question 3000 Answer',
                    QuestionMark: 1);
                questions.add(q1);
                questions.add(q2);
                questions.add(q3);
                //needs quiz parameter
                Quiz quiz = Quiz(
                    QuizName: 'Quiz 1 Name',
                    QuizCategory: 'Cat 2',
                    QuizDescription: 'Quiz 1jaskdjgdDescription',
                    QuizMark: 3,
                    QuizDateCreated: 'QuizDateCreated',
                    QuizQuestions: questions,
                    QuizID: '');

                await service.addQuizWithQuestions(quiz);
              },
              child: Text('Add Quiz With List of Question'),
            ),
            //get Categories
            TextButton(
              onPressed: () async {
                List? Categories = await service.getCategories();
                print(Categories);
              },
              child: Text('listQuizzes.elementAt(0).QuizName'),
            ),
            //get all quizzes
            TextButton(
              onPressed: () {
                print(listQuizzes.elementAt(0).QuizName);
                // List<Quiz>? AllQuizzes = await service.getAllQuizzes();
                // print(AllQuizzes!.length);
                // print(AllQuizzes.elementAt(0).QuizName);
              },
              child: Text('Get All Quizzes'),
            ),
            //get quiz and question
            TextButton(
              onPressed: () async {
                Quiz? quiz = await service.getQuizAndQuestions(
                    QuizID: 'ZpoDXDUduIAWviwBJsYi');
                print(quiz!.QuizQuestions.elementAt(0).QuestionText);
                print(quiz!.QuizQuestions.elementAt(1).QuestionText);
                print(quiz!.QuizQuestions.elementAt(2).QuestionText);
              },
              child: Text('Get Quiz with Questions'),
            ),
            //get quiz based on cat
            TextButton(
              onPressed: () async {
                List<Quiz>? CategoryQuiz =
                    await service.getQuizByCategory(Category: 'Cat 2');
                print(CategoryQuiz!.length);
              },
              child: Text('Get Category based Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
