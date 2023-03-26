import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kwiz/Models/Questions.dart';
import 'package:kwiz/Models/Quizzes.dart';

class DatabaseService {
  //Quiz Collection Name
  final CollectionReference quizCollection =
      FirebaseFirestore.instance.collection('Quizzes');

  //Category Colection Name
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('Categories');

  //-----------------------------------------------------------------------------------------------------------------------------------------------------
  //add quiz
  //This method adds a 'quiz' to the Quiz-Collection and adds a list of 'questions' in a Sub-Collection(called Questions) of the added 'quiz'
  Future<void> addQuizWithQuestions(Quiz QuizInstance) async {
    //the var result returns the quiz object that has just been added to the database
    var result = await quizCollection.add({
      'QuizName': QuizInstance.QuizName,
      'QuizCategory': QuizInstance.QuizCategory,
      'QuizDescription': QuizInstance.QuizDescription,
      'QuizMark': QuizInstance.QuizMark,
      'QuizDateCreated': QuizInstance.QuizDateCreated,
    });

    //this uses the quiz ID and adds each question to a SUb Collection
    String quizId = result.id;
    QuizInstance.QuizQuestions.forEach((question) async {
      await _addQuestionDocument(QuizID: quizId, Question: question);
    });
  }

  //add question
  //This private method is called by the addQuizWithQuestions method and adds one question to the database at a time
  Future<void> _addQuestionDocument(
      {String? QuizID, Question? Question}) async {
    quizCollection.doc(QuizID).collection('Questions').add({
      'QuestionAnswer': Question!.QuestionAnswer,
      'QuestionMark': Question!.QuestionMark,
      'QuestionNumber': Question!.QuestionNumber,
      'QuestionText': Question!.QuestionText,
    });
  }
  //-----------------------------------------------------------------------------------------------------------------------------------------------------

  //-----------------------------------------------------------------------------------------------------------------------------------------------------
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
  //-----------------------------------------------------------------------------------------------------------------------------------------------------

  //-----------------------------------------------------------------------------------------------------------------------------------------------------
  //get all Quizzes
  //This method gets all the quizzes from the Quiz Collection and retruns them as a list of Quiz objects
  Future<List<Quiz>?> getAllQuizzes() async {
    List<Quiz> Quizzes = [];
    //gets all docs from collection
    QuerySnapshot collectionSnapshot = await quizCollection.get();
    //loops through each document and creates quiz object and adds to quiz list
    for (int i = 0; i < collectionSnapshot.docs.length; i++) {
      var docSnapshot = collectionSnapshot.docs[i];
      late List<Question> Questions = [];
      Quiz quiz = Quiz(
          QuizName: docSnapshot['QuizName'],
          QuizCategory: docSnapshot['QuizCategory'],
          QuizDescription: docSnapshot['QuizDescription'],
          QuizMark: docSnapshot['QuizMark'],
          QuizDateCreated: docSnapshot['QuizDateCreated'],
          QuizQuestions: Questions,
          QuizID: docSnapshot.id);
      Quizzes.add(quiz);
    }
    return Quizzes;
  }
  //-----------------------------------------------------------------------------------------------------------------------------------------------------

  //-----------------------------------------------------------------------------------------------------------------------------------------------------
  //get all Quiz and Questions
  //This method gets the selected quiz from the Quiz Collection and its subcollection of questions and retruns a quiz object with a list of ordered questions
  Future<Quiz?> getQuizAndQuestions({String? QuizID}) async {
    late List<Question> questions = [];

    DocumentSnapshot docSnapshot = await quizCollection.doc(QuizID).get();

    Quiz quiz = Quiz(
        QuizName: docSnapshot['QuizName'],
        QuizCategory: docSnapshot['QuizCategory'],
        QuizDescription: docSnapshot['QuizDescription'],
        QuizMark: docSnapshot['QuizMark'],
        QuizDateCreated: docSnapshot['QuizDateCreated'],
        QuizQuestions: questions,
        QuizID: docSnapshot.id);

    QuerySnapshot collectionSnapshot =
        await quizCollection.doc(QuizID).collection('Questions').get();

    for (int i = 0; i < collectionSnapshot.docs.length; i++) {
      var docSnapshot = collectionSnapshot.docs[i];
      Question question = Question(
          QuestionNumber: docSnapshot['QuestionNumber'],
          QuestionText: docSnapshot['QuestionText'],
          QuestionAnswer: docSnapshot['QuestionAnswer'],
          QuestionMark: docSnapshot['QuestionMark']);

      questions.add(question);
    }

    quiz.QuizQuestions.sort(
        (a, b) => a.QuestionNumber.compareTo(b.QuestionNumber));

    return quiz;
  }
  //-----------------------------------------------------------------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------------------------------------------------------------
  //get Quiz based on category
  //This method gets quizzes from the Quiz Collection based on its category
  Future<List<Quiz>?> getQuizByCategory({String? Category}) async {
    List<Quiz> Quizzes = [];
    //exacutes a query based on field value
    Query<Object?> collectionQuery =
        await quizCollection.where('QuizCategory', isEqualTo: Category);

    //converts query to snapshot
    QuerySnapshot collectionSnapshot = await collectionQuery.get();

    //loops through each document and creates quiz object and adds to quiz list
    for (int i = 0; i < collectionSnapshot.docs.length; i++) {
      var docSnapshot = collectionSnapshot.docs[i];
      late List<Question> Questions = [];
      Quiz quiz = Quiz(
          QuizName: docSnapshot['QuizName'],
          QuizCategory: docSnapshot['QuizCategory'],
          QuizDescription: docSnapshot['QuizDescription'],
          QuizMark: docSnapshot['QuizMark'],
          QuizDateCreated: docSnapshot['QuizDateCreated'],
          QuizQuestions: Questions,
          QuizID: docSnapshot.id);
      Quizzes.add(quiz);
    }
    return Quizzes;
  }
  //-----------------------------------------------------------------------------------------------------------------------------------------------------
}
