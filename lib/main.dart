import 'package:flutter/material.dart';
import 'QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: QuizPage()),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPressedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    setState(() {
    if (userPressedAnswer == correctAnswer) {
      scoreKeeper.add(Icon(
        Icons.check,
        color: Colors.green,
      ));
    }
    else{
      scoreKeeper.add(Icon(
        Icons.close,
        color: Colors.red,
      ));
    }
      quizBrain.nextQuestion();

    if(quizBrain.isFinished() == true){
      print('We are at the end!');
      Alert(context: context, title: "Finished!", desc: "You've reached the end of the quiz!").show();
      quizBrain.reset();
      scoreKeeper = [];
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: MaterialButton(
              onPressed: () {
                checkAnswer(true);
              },
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              color: Colors.green,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: MaterialButton(
              onPressed: () {
                checkAnswer(false);
              },
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              color: Colors.red,
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
