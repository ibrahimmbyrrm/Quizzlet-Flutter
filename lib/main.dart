import 'package:flutter/material.dart';
import 'package:quizzlet/question.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzlet());

class Quizzlet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child:Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Widget> scoreKeeper = [];

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {
      if (quizBrain.isFinished()) {
        Alert(
          context: context,
          title: "Finished!",
          desc: "You've reached the end of the quiz."
        ).show();
        quizBrain.reset();
        scoreKeeper = [];
      }else {
        if (correctAnswer == userAnswer) {
          scoreKeeper.add(Icon(Icons.check,color: Colors.green,));
        }else {
          scoreKeeper.add(Icon(Icons.close,color: Colors.red,));
        }
        quizBrain.nextQuestion();
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white
                ),
              ),
            ),
          ),
        ),
        Expanded(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
                ),
                onPressed: () {
                  checkAnswer(true);
                },
                child: Text(
                  "True",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
              ),
            )
        ),
        Expanded(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red
                ),
                onPressed: () {
                  checkAnswer(false);
                },
                child: Text(
                  "False",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
              ),
            )
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
/*
question1 : "You can lead a cow down stairs but not up stairs." -> False
question2 : "Approximately one quaret of human bones are in the feet." -> True
question3 : "A slug's blood is green." -> True
 */
