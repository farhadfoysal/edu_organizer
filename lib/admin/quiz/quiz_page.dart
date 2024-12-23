import 'dart:async';
import 'package:class_organizer/admin/quiz/questions.dart';
import 'package:class_organizer/admin/quiz/result_page.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final void Function(String answer, String questionText) onSelectedAnswer;
  final List<String> selectedAnswers;
  final void Function() switchResult;
  const QuizPage({
    super.key,
    required this.onSelectedAnswer, required this.selectedAnswers, required this.switchResult,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  var currentQuestionIndex = 0;
  List<String> _shuffledAnswers = [];
  bool hasFinished = false;
  Map<int, String> selectedAnswersMap = {}; // Stores selected answers by question index
  Map<String, String> selectedAnswersMapTwo = {};
  // void answerQuestion(String answer) {
  //   widget.onSelectedAnswer(answer);
  //   setState(() {
  //     currentQuestionIndex++;
  //   });
  // }

  void answerQuestion(String answer,String questionText) {
    setState(() {
      if(currentQuestionIndex < questions.length ){

        if (!selectedAnswersMap.containsKey(currentQuestionIndex)) {
        // if (!selectedAnswersMapTwo.containsKey(questionText)) {
        // selectedAnswersMapTwo[questionText] = answer; // Map questionText to the selected answer

        selectedAnswersMap[currentQuestionIndex] = answer;

        widget.onSelectedAnswer(answer,questionText);

        currentQuestionIndex++;
      } else {
        print('Answer already selected for this question.');
      }


      }

      // print(currentQuestionIndex);
      // print(questions.length);
      if (currentQuestionIndex < questions.length) {
        _shuffledAnswers = questions[currentQuestionIndex].getShuffledAnswers();
      }else{
        setState(() {
          finishedExam();
        });
      }
    });
  }

  void nextQuestion(int n) {
    setState(() {
      currentQuestionIndex = (currentQuestionIndex + n) % questions.length;
      if (currentQuestionIndex < questions.length) {
        _shuffledAnswers = questions[currentQuestionIndex].getShuffledAnswers();
      }else{
        setState(() {
          finishedExam();
        });
      }
    });
  }

  void prevQuestion(int n) {
    setState(() {
      currentQuestionIndex =
          (currentQuestionIndex - n + questions.length) % questions.length;
      if (currentQuestionIndex < questions.length) {
        _shuffledAnswers = questions[currentQuestionIndex].getShuffledAnswers();
      }else{
        setState(() {
          finishedExam();
        });
      }
    });
  }

    bool isCorrectAnswer(String answer) {
    int inde = currentQuestionIndex;
    return questions[inde-1].questionAnswers[0] == answer;
  }

  // void nextQuestion(int n){
  //   setState(() {
  //     if(currentQuestionIndex < questions.length ){
  //       currentQuestionIndex = currentQuestionIndex + n;
  //     }
      
  //           if (currentQuestionIndex < questions.length) {
  //       _shuffledAnswers = questions[currentQuestionIndex].getShuffledAnswers();
  //     }else{
  //       setState(() {
  //         finishedExam();
  //       });
  //     }
  //   });
  // }

  // void prevQuestion(int n){
  //   setState(() {
  //     if(currentQuestionIndex < questions.length ){
  //       currentQuestionIndex = currentQuestionIndex - n;
  //     }
  //           if (currentQuestionIndex < questions.length) {
  //       _shuffledAnswers = questions[currentQuestionIndex].getShuffledAnswers();
  //     }else{
  //       setState(() {
  //         finishedExam();
  //       });
  //     }
  //   });
  // }

  late Timer _timer;
  int _remainingSeconds = 120;

  void getQuestion(){
    _shuffledAnswers = questions[currentQuestionIndex].getShuffledAnswers();
  }

  @override
  void initState() {
    super.initState();
    getQuestion();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer.cancel();
        _onTimeUp();
      }
    });
  }


void finishedExam() {
  if (hasFinished) return;
  hasFinished = true;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Are you sure!"),
      content: const Text("Do you want to finish your quiz?"),
      actions: [

        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            hasFinished = false;
          },
          child: const Text("CANCEL"),
        ),

        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.switchResult();
          },
          child: const Text("SUBMIT"),
        ),
      ],
    ),
  );
}

  void _onTimeUp() {



    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Time's Up!"),
        content: const Text("You ran out of time for this question."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.switchResult();
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResultPage(widget.selectedAnswers, switchScreen: widget.switchScreen, selectedAnswers: [],)));
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }


void showFeedbackSnackbar(BuildContext context, String message, bool isCorrect) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    backgroundColor: isCorrect ? Colors.green : Colors.red,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2),
    margin: const EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = currentQuestionIndex < questions.length ? questions[currentQuestionIndex] : questions[questions.length - 1];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Quiz",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timer
            Center(
              child: Text(
                "Time Left: ${_formatTime(_remainingSeconds)}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _remainingSeconds <= 10 ? Colors.red : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Question Text
            Text(
              currentQuestion.questionTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            // Options
            Expanded(
              child: ListView(
                // ...currentQuestion.getShuffledAnswers()
                children: _shuffledAnswers.map((answer) {
                  final isSelected =
                      selectedAnswersMap[currentQuestionIndex] == answer;
                  return QuizOption(
                    optionText: answer,
                    isSelected: isSelected,
                    onPressed: () {
                      answerQuestion(answer,currentQuestion.questionTitle);
                      if (isCorrectAnswer(answer)) {
                        showFeedbackSnackbar(context,"Correct!",true);
                      } else {
                        showFeedbackSnackbar(context,"Wrong!",false);
                      }
                    },
                  );
                }).toList(),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: currentQuestionIndex > 0 ? () {
                      prevQuestion(1);
                      } : null, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        nextQuestion(1);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Progress Indicator (Horizontal Scroll View)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(10, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0), // Space between circles
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: index < 4 ? Colors.black : Colors.grey[300],
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: index < 4 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizOption extends StatelessWidget {
  final String optionText;
  final bool isSelected;
  final void Function() onPressed;
  const QuizOption({
    Key? key,
    required this.optionText,
    required this.isSelected, required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey,
            width: 1.5,
          ),
          color: isSelected ? Colors.grey[300] : Colors.white,
        ),
        child: ListTile(
          title: Text(
            optionText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: isSelected ? Colors.black : Colors.grey[700],
            ),
          ),
          onTap: onPressed,
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class QuizPage extends StatefulWidget {
//   const QuizPage({super.key, required void Function(String answer) onSelectedAnswer});

//   @override
//   State<QuizPage> createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           "Quiz",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Question Text
//             Text(
//               "Which cricketer was known as the 'Sultan of Swing'?",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(height: 16),
//             // Options
//             Expanded(
//               child: ListView(
//                 children: [
//                   QuizOption(
//                     optionText: "Wasim Akram",
//                     isSelected: false,
//                   ),
//                   QuizOption(
//                     optionText: "Glenn McGrath",
//                     isSelected: false,
//                   ),
//                   QuizOption(
//                     optionText: "Curtly Ambrose",
//                     isSelected: true,
//                   ),
//                   QuizOption(
//                     optionText: "Courtney Walsh",
//                     isSelected: false,
//                   ),
//                 ],
//               ),
//             ),
//             // Navigation Buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Handle back action
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.black,
//                         shape: CircleBorder(),
//                         padding: EdgeInsets.all(16),
//                       ),
//                       child: Icon(Icons.arrow_back, color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Handle next action
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.black,
//                         shape: CircleBorder(),
//                         padding: EdgeInsets.all(16),
//                       ),
//                       child: Icon(Icons.arrow_forward, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: 24),
//             // Progress Indicator (Horizontal Scroll View)
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: List.generate(10, (index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 8.0), // Space between circles
//                     child: CircleAvatar(
//                       radius: 16,
//                       backgroundColor: index < 4 ? Colors.black : Colors.grey[300],
//                       child: Text(
//                         "${index + 1}",
//                         style: TextStyle(
//                           color: index < 4 ? Colors.white : Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class QuizOption extends StatelessWidget {
//   final String optionText;
//   final bool isSelected;

//   const QuizOption({
//     Key? key,
//     required this.optionText,
//     required this.isSelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: isSelected ? Colors.black : Colors.grey,
//             width: 1.5,
//           ),
//           color: isSelected ? Colors.grey[300] : Colors.white,
//         ),
//         child: ListTile(
//           title: Text(
//             optionText,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//               color: isSelected ? Colors.black : Colors.grey[700],
//             ),
//           ),
//           onTap: () {
//             // Handle option selection
//           },
//         ),
//       ),
//     );
//   }
// }