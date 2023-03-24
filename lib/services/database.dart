import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kwiz/Models/Questions.dart';
import 'package:kwiz/Models/Quizzes.dart';

class DatabaseService {
  //Quiz Collection Name
  final CollectionReference quizCollection =
      FirebaseFirestore.instance.collection('Quizzes');

  //This method adds a 'quiz' to the Quiz-Collection... Add parameter to send through a Quizzes Model(populated via gui)
  Future<String> addQuizDocument(Quiz QuizInstance) async {
    //add field names and values of the fields in{}
    //the var quiz returns the quiz object that has just been added to the database
    var quiz = await quizCollection.add({
      'QuizName': QuizInstance.QuizName,
      'QuizCategory': QuizInstance.QuizCategory,
      'QuizDescription': QuizInstance.QuizDescription,
      'QuizMark': QuizInstance.QuizMark,
      'QuizDateCreated': QuizInstance.QuizDateCreated,
    });

    //maybe return the quizID so when quuestions are add the quizID can be sent
    String ID = quiz.id;
    return ID;
  }

  //This method adds question Documents to the Quiz's Question Sub-Collection
  Future<void> addQuestionDocument({String? QuizID}) async {
    quizCollection.doc(QuizID).collection('Questions').add({'q': 'question'});
  }

  //add quiz
  //add question

  //get all quizzes - luca - return a list of Quizzes without questions
  //get specific quiz with questions(answers)- christine
  //get all quizzes by category - michael
}
