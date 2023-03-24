import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kwiz/Models/Questions.dart';
import 'package:kwiz/Models/Quizzes.dart';

class DatabaseService {
  //Quiz Collection Name
  final CollectionReference quizCollection =
      FirebaseFirestore.instance.collection('Quizzes');

  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('Categories');

  //add quiz
  //This method adds a 'quiz' to the Quiz-Collection... Add parameter to send through a Quizzes Model(populated via gui)
  Future<String> addQuizDocument(Quiz QuizInstance) async {
    //the var quiz returns the quiz object that has just been added to the database
    var quiz = await quizCollection.add({
      'QuizName': QuizInstance.QuizName,
      'QuizCategory': QuizInstance.QuizCategory,
      'QuizDescription': QuizInstance.QuizDescription,
      'QuizMark': QuizInstance.QuizMark,
      'QuizDateCreated': QuizInstance.QuizDateCreated,
    });

    //retruns the quiz ID so questions added are
    String ID = quiz.id;
    return ID;
  }

  //add question
  //This method adds question Documents to the Quiz's Question Sub-Collection (Will either iterate through list of question and add each item in list or will do 1 at a time)
  Future<void> addQuestionDocument({String? QuizID}) async {
    quizCollection.doc(QuizID).collection('Questions').add({'q': 'question'});
  }

  //get Categories
  //This method gets the one and only document from the Category collection and returns the items stored in the docs array as a list
  Future<List?> getCategories() async {
    // Get doc from Category collection
    DocumentSnapshot docSnapshot =
        await categoryCollection.doc('gbdJOUgd8F5z26sKfjxu').get();

    // Get data from doc and return as array
    final CategoryList = docSnapshot['CategoryName'];
    return CategoryList;
  }

  //get all Quizzes
  Future<void> getQuizzes() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await quizCollection.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(allData);
  }

  //get all quizzes - luca - return a list of Quizzes without questions, should probably contain the quiz ID too
  //get specific quiz with questions(answers)- christine
  //get all quizzes by category - michael
}
