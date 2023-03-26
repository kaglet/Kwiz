import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kwiz/hello.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Get the questions from firebase 
  final List<String> questions = [
    'What is the capital of France?',
    'What river is not crossed by any brigdes?',
    'What is the smallest country in the world by land area?'
  ];

  //get answers from firebase and store as this list

  final List<String> answers = ['Paris', 'Amazon', 'Vatican City'];

  // Controller for the answer input field
  TextEditingController answerController = TextEditingController();
  
  //user input answers
  List<String> userAnswers = List.filled(3, '');        //make this dynamic!!!

  //get quizname from firebase
  final String quizName = 'PlaceHolder :)';

  // Index of the current question
  int currentIndex = 0;


  @override
  Widget build(BuildContext context) { 
    void updateText(){
      answerController.text = userAnswers[currentIndex];
    }   
    
    return Scaffold(
      appBar: AppBar(
        title: Text(quizName),          // save the title as a global variabe thats pulled from firebase as well
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Image.asset('assets/images/geo1.jpg'),
            ),
            // Display the question number and question text
            Text(
              'Question ${currentIndex + 1} of ${questions.length}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              questions[currentIndex],
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32.0),
            // Input field for the answer
          
            TextField(
              controller: answerController,
              
              decoration: InputDecoration(
                hintText: 'Type your answer here',
                hintStyle: TextStyle(color: Color.fromARGB(255, 107, 106, 106)),
              ),
            ),

            SizedBox(height: 32.0),
            // Buttons for moving to the previous/next question
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentIndex > 0)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentIndex--;
                        updateText();
                        //answerController.clear();
                        // print('here');   WHY ITS NOT PRINTING IN OUTPUT?????
                      }
                      );
                    },
                    child: Text('Previous'),
                  ),
                if (currentIndex < questions.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      userAnswers[currentIndex] = answerController.text.trim();
                      /////userAnswers.add(answerController.text.trim());
                      // print(userAnswers);
                      setState(() {
                        currentIndex++;
                        updateText();
                        //answerController.clear();
                      });
                    },
                    child: Text('Next'),
                  ),
                // Show a submit button on the last question
                if (currentIndex == questions.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      // Calculate the score

                      userAnswers[currentIndex] = answerController.text.trim();
                      int score = 0;
                      for (int i = 0; i < questions.length; i++) {
                        if (userAnswers[i].toLowerCase() == answers[i].toLowerCase()) {
                          score++;
                          //print(answerController.text);
                        }
                      }
                      // Show the score in an alert dialog

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Quiz Complete'),
                            content: Text('Your score: $score / ${questions.length}'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );

                      
                      // //TESTING MOVING FROM SCREEN TO SCREEN
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HelloPage()),
                      //  );


                    },
                    child: Text('Submit'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


//ADDING BACKGROUND

// @override
// Widget build(BuildContext context) {
//   return DecoratedBox(
//     decoration: BoxDecoration(
//       image: DecorationImage(image: AssetImage("asset/images/geo1.jpg"), fit: BoxFit.cover),
//     ),
//     child: Center(child: FlutterLogo(size: 300)),
//   );
// }


//USE WIDGET INSPECTOR type Ctrl + T and search >Dart: Open DevTools
//Flex makes it "become small" can be squashed :) the picture of the globe is squashed when we click on input box. 

/*PROBLEMS:
        >> [SOLVED :D] texteditingcontroller is the same for all questions. 
                ...do i create new tec for each question?
        >> [SOLVED :D] want text to remain when i press previous but only one answer saved?????
        >> [SOLVED] having trouble adding comparing userAnswers and answer lists. 
        >> [SOLVED] set flex for picture perma 

*/