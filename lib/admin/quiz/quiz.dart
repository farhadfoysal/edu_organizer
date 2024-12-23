import 'package:class_organizer/admin/quiz/questions.dart';
import 'package:class_organizer/admin/quiz/quiz_page.dart';
import 'package:class_organizer/admin/quiz/result_page.dart';
import 'package:class_organizer/admin/quiz/start_quiz.dart';
import 'package:flutter/material.dart';


class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {

  var activeScreen = "start-screen";
  List<String> selectedAnswer = [];
  bool hasFinished = false;

  void switchScreen(){
    setState(() {
      selectedAnswer = [];
      activeScreen = "question-screen";
    });
  }

  void switchResult(){
    setState(() {
      activeScreen = "result-screen";
    });
  }

  bool isQuizComplete() {
    return selectedAnswer.length == questions.length;
  }

  void onSelectedAnswer(String answer, String questionText){
    // selectedAnswer.add(answer);
    // // print(selectedAnswer.length);
    // selectedAnswer.length == questions.length ? setState(() {
    //   // activeScreen = "result-screen";
    //   finishedExam();
    // }): null;
    setState(() {
      selectedAnswer = [...selectedAnswer, answer];
      if (selectedAnswer.length == questions.length) {
        finishedExam();
      }
          // if (isQuizComplete()) {
          //   finishedExam();
          // }
    });

  }

void finishedExam() {
  if (hasFinished) return;
  hasFinished = true;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Are you sure?"),
      content: const Text("Do you want to finish your quiz?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("CANCEL"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            hasFinished = false;
            setState(() {
              activeScreen = "result-screen";
            });
          },
          child: const Text("SUBMIT"),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {

    final screenWidget = activeScreen ==  "start-screen" ? StartQuiz(switchScreen) : activeScreen == "question-screen" ? QuizPage(selectedAnswers: selectedAnswer,onSelectedAnswer: onSelectedAnswer, switchResult: switchResult) : ResultPage(switchScreen: switchScreen, selectedAnswer: selectedAnswer,);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 252, 242, 156),
                  const Color.fromARGB(255, 223, 247, 86),
                ]),
          ),
          child: screenWidget,
        ),
        
      );
  }
}