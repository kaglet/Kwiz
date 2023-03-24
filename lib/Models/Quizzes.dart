import 'package:kwiz/Models/Questions.dart';

class Quiz {
  final String QuizName;
  final String QuizCategory;
  final String QuizDescription;
  final int QuizMark;
  final String QuizDateCreated;

  final List<Question> Questions;

  Quiz({
    required this.QuizName,
    required this.QuizCategory,
    required this.QuizDescription,
    required this.QuizMark,
    required this.QuizDateCreated,
    required this.Questions,
  });
}
