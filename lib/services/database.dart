import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kwiz/Models/questions.dart';
import 'package:kwiz/Models/quizzes.dart';

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
  Future<void> addQuizWithQuestions(Quiz quizInstance) async {
    //the var result returns the quiz object that has just been added to the database
    var result = await quizCollection.add({
      'QuizName': quizInstance.quizName,
      'QuizCategory': quizInstance.quizCategory,
      'QuizDescription': quizInstance.quizDescription,
      // 'QuizMark': quizInstance.QuizMark,
      'QuizDateCreated': quizInstance.quizDateCreated,
    });

    //this uses the quiz ID and adds each question to a SUb Collection
    String quizId = result.id;
    quizInstance.quizQuestions.forEach((question) async {
      await _addQuestionDocument(quizID: quizId, question: question);
    });
  }

  //add question
  //This private method is called by the addQuizWithQuestions method and adds one question to the database at a time
  Future<void> _addQuestionDocument(
      {String? quizID, Question? question}) async {
    quizCollection.doc(quizID).collection('Questions').add({
      'QuestionAnswer': question!.questionAnswer,
      // 'QuestionMark': question!.QuestionMark,
      'QuestionNumber': question.questionNumber,
      'QuestionText': question.questionText,
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
    final categoryList = docSnapshot['CategoryName'];
    return categoryList;
  }
  //-----------------------------------------------------------------------------------------------------------------------------------------------------

  //-----------------------------------------------------------------------------------------------------------------------------------------------------
  //get all Quiz Info only
  //This method gets the selected quiz from the Quiz Collection and its information
  Future<Quiz?> getQuizInformationOnly({String? quizID}) async {
    late List<Question> questions = [];
    DocumentSnapshot docSnapshot = await quizCollection.doc(quizID).get();

    Quiz quiz = Quiz(
        quizName: docSnapshot['QuizName'],
        quizCategory: docSnapshot['QuizCategory'],
        quizDescription: docSnapshot['QuizDescription'],
        quizMark: 0,
        quizDateCreated: docSnapshot['QuizDateCreated'],
        quizQuestions: questions,
        quizID: docSnapshot.id);

    return quiz;
  }
  //-----------------------------------------------------------------------------------------------------------------------------------------------------

  //-----------------------------------------------------------------------------------------------------------------------------------------------------
  //get all Quizzes
  //This method gets all the quizzes from the Quiz Collection and retruns them as a list of Quiz objects
  Future<List<Quiz>?> getAllQuizzes() async {
    List<Quiz> quizzes = [];
    //gets all docs from collection
    QuerySnapshot collectionSnapshot = await quizCollection.get();
    //loops through each document and creates quiz object and adds to quiz list
    for (int i = 0; i < collectionSnapshot.docs.length; i++) {
      var docSnapshot = collectionSnapshot.docs[i];
      late List<Question> questions = [];
      Quiz quiz = Quiz(
          quizName: docSnapshot['QuizName'],
          quizCategory: docSnapshot['QuizCategory'],
          quizDescription: docSnapshot['QuizDescription'],
          // QuizMark: docSnapshot['QuizMark'],
          quizMark: 0,
          quizDateCreated: docSnapshot['QuizDateCreated'],
          quizQuestions: questions,
          quizID: docSnapshot.id);
      quizzes.add(quiz);
    }
    return quizzes;
  }
  //-----------------------------------------------------------------------------------------------------------------------------------------------------

  //-----------------------------------------------------------------------------------------------------------------------------------------------------
  //get all Quiz and Questions
  //This method gets the selected quiz from the Quiz Collection and its subcollection of questions and retruns a quiz object with a list of ordered questions
  Future<Quiz?> getQuizAndQuestions({String? quizID}) async {
    late List<Question> questions = [];

    try {
      DocumentSnapshot docSnapshot = await quizCollection.doc(quizID).get();
      Quiz quiz = Quiz(
          quizName: docSnapshot['QuizName'],
          quizCategory: docSnapshot['QuizCategory'],
          quizDescription: docSnapshot['QuizDescription'],
          quizMark: 0,
          quizDateCreated: docSnapshot['QuizDateCreated'],
          quizQuestions: questions,
          quizID: docSnapshot.id);

      QuerySnapshot collectionSnapshot =
          await quizCollection.doc(quizID).collection('Questions').get();
      for (int i = 0; i < collectionSnapshot.docs.length; i++) {
        var docSnapshot = collectionSnapshot.docs[i];
        Question question = Question(
            questionNumber: docSnapshot['QuestionNumber'],
            questionText: docSnapshot['QuestionText'],
            questionAnswer: docSnapshot['QuestionAnswer'],
            questionMark: 0);

        questions.add(question);
      }

      quiz.quizQuestions
          .sort((a, b) => a.questionNumber.compareTo(b.questionNumber));

      return quiz;
    } catch (e) {
      print("Error!!!!! - $e");
    }
  }
  //-----------------------------------------------------------------------------------------------------------------------------------------------------

  //-----------------------------------------------------------------------------------------------------------------------------------------------------
  //get Quiz based on category
  //This method gets quizzes from the Quiz Collection based on its category
  Future<List<Quiz>?> getQuizByCategory({String? category}) async {
    List<Quiz> quizzes = [];
    //exacutes a query based on field value
    Query<Object?> collectionQuery =
        await quizCollection.where('QuizCategory', isEqualTo: category);

    //converts query to snapshot
    QuerySnapshot collectionSnapshot = await collectionQuery.get();

    //loops through each document and creates quiz object and adds to quiz list
    for (int i = 0; i < collectionSnapshot.docs.length; i++) {
      var docSnapshot = collectionSnapshot.docs[i];
      late List<Question> questions = [];
      Quiz quiz = Quiz(
          quizName: docSnapshot['QuizName'],
          quizCategory: docSnapshot['QuizCategory'],
          quizDescription: docSnapshot['QuizDescription'],
          quizMark: 0,
          quizDateCreated: docSnapshot['QuizDateCreated'],
          quizQuestions: questions,
          quizID: docSnapshot.id);
      quizzes.add(quiz);
    }
    return quizzes;
  }
  //-----------------------------------------------------------------------------------------------------------------------------------------------------

  //-----------------------------------------------------------------------------------------------------------------------------------------------------
  //streams
  //get quiz stream

  Stream<QuerySnapshot> get getQuizzes {
    return quizCollection.snapshots();
  }
  //-----------------------------------------------------------------------------------------------------------------------------------------------------
}
