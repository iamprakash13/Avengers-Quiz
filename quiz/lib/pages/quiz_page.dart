import 'package:flutter/material.dart';

import '../utils/question.dart';
import '../utils/quiz.dart';

import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/correct_wrong_overlay.dart';

import './score_page.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Captain America's Shield is made of vibranium", true),
    new Question("Captain America sponsered the black panther", true),
    new Question("Martin Goodman started Marvel", true),
     new Question("Nebula is an Adopted Daughter of InterGalactic WarLord", true),
      new Question("Patsy Walker became Hellcat", true),
       new Question("Thor's hammer is called Mjolnir", true),
        new Question("Rick Jones was made an honorary Avenger", true),
 new Question("After thanos snap,the half of universe disintegrate", true),
  new Question("Some of 'The Avengers' have appeared on 'The Tonight Show'", false),
   new Question("Actress Emma Watson plays Black Widow", false),
    new Question("Groot lost his life in Guardians of Galaxy", true),
     new Question("Legendary hero of 20th Century who was honored by the 30th Century 'Guardians of Galaxy' was Spiderman", false),
      new Question("Wanda and Pietro are twins", true),
       new Question("Ava and Foster go into hiding", true),
        new Question("Hank Pym is Real Avenger", true),
         new Question("As the Hulk gets angrier, he gets stronger", true),
          new Question("Iron Man & Thor discovered each others secret identity", true),
         new Question("Hawkeye's real name is Steve Rodgers", false),
          new Question("Pym recuses Hope form Quantam field", true),
           new Question("Loki is called as 'god of mischief'", true),
            new Question("Lang left drifting in the quantum realm", true),
             new Question("The First Avengers movie come out in 2012", true),
              new Question("Stark,Nebula,bannerM'Baku,Okoye,Rhodes,Rocket,Rogers,Romanoff and Thor survived after thanos snap", true),
               new Question("Quicksilver's power is SuperSpeed", true),
                new Question("Maria Hill and Nick Fury survived after thanos snap", false),
                 new Question("The Sub-Mariner was the first hero to become a replacement Avenger,after the originals wanted to take a vacation", false),
                  new Question("Thanos wielding the Infinity Gauntlet", true),
                   new Question("Thanos watches a sunset on another planet", false),
                   new Question("Stark senses that greater threat approaching Earth", true),
                   new Question(" Fury is unable to transmit a signal ", false),
                   new Question(" Captain Marvel is upcoming movie of avenger series", true),
  ]);
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column( // This is our main page
          children: <Widget>[
            new AnswerButton(true, () => handleAnswer(true)), //true button
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false, () => handleAnswer(false)), // false button
          ],
        ),
        overlayShouldBeVisible == true ? new CorrectWrongOverlay(
          isCorrect,
          () {
            if (quiz.length == questionNumber) {
              Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new ScorePage(quiz.score, quiz.length)), (Route route) => route == null);
              return;
            }
            currentQuestion = quiz.nextQuestion;
            this.setState(() {
              overlayShouldBeVisible = false;
              questionText = currentQuestion.question;
              questionNumber = quiz.questionNumber;
            });
          }
        ) : new Container()
      ],
    );
  }
}