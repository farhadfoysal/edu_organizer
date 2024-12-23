import 'package:class_organizer/admin/quiz/questions.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {

  final void Function() switchScreen;
  final List<String> selectedAnswer;
  const ResultPage({
    super.key,
    required this.switchScreen, required this.selectedAnswer,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<QuestionResult> selectedAnswers = [];

  double getPercentage() {
    int correctCount = selectedAnswers.where((result) => result.isCorrect).length;
    return (correctCount / selectedAnswers.length) * 100;
  }

  int getCorrectCount() {
    return selectedAnswers.where((result) => result.isCorrect).length;
  }

  int getIncorrectCount() {
    return selectedAnswers.where((result) => !result.isCorrect).length;
  }

  List<Map<String, Object>> getQuizSummary() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < selectedAnswers.length; i++) {
      summary.add({
        'question_number': i + 1,
        'question_title': questions[i].questionTitle,
        'correct_answer': questions[i].questionAnswers[0],
        'selected_answer': selectedAnswers[i],
        'color': selectedAnswers[i] == questions[i].questionAnswers[0]
            ? Colors.greenAccent
            : Colors.redAccent
      });
    }

    return summary;
  }

  void getResult() {
    for (var i = 0; i < widget.selectedAnswer.length; i++) {
      selectedAnswers.add(
        QuestionResult(
          questionText: questions[i].questionTitle,
          selectedAnswer: widget.selectedAnswer[i],
          correctAnswer: questions[i].questionAnswers[0],
          explanation: questions[i].explanation,
          isCorrect: widget.selectedAnswer[i] == questions[i].questionAnswers[0],
        ),
      );
    }

    print(widget.selectedAnswer);
  }

  @override
  void initState() {
    super.initState();
    getResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            const Text(
              "Results",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Score: ${getPercentage().toStringAsFixed(2)}% Correct: ${getCorrectCount()} | Incorrect: ${getIncorrectCount()}",
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: selectedAnswers.length,
          itemBuilder: (context, index) {
            final question = selectedAnswers[index];
            return ResultCard(
              question: question,
              onFavoriteToggle: () {
                setState(() {
                  question.isFavorite = !question.isFavorite;
                });
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: widget.switchScreen,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
          ),
          child: const Text(
            "Retake Quiz",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final QuestionResult question;
  final VoidCallback onFavoriteToggle;

  const ResultCard({
    Key? key,
    required this.question,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.questionText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Your Answer: ${question.selectedAnswer}",
              style: TextStyle(
                fontSize: 16,
                color: question.isCorrect ? Colors.green : Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Correct Answer: ${question.correctAnswer}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Explanation: ${question.explanation}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: onFavoriteToggle,
                icon: Icon(
                  question.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: question.isFavorite ? Colors.red : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionResult {
  final String questionText;
  final String selectedAnswer;
  final String correctAnswer;
  final String explanation;
  bool isCorrect;
  bool isFavorite;

  QuestionResult({
    required this.questionText,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.explanation,
    required this.isCorrect,
    this.isFavorite = false,
  });
}



// import 'package:class_organizer/admin/quiz/questions.dart';
// import 'package:flutter/material.dart';

// class ResultPage extends StatefulWidget {

//   final void Function() switchScreen;
//   final List<String> selectedAnswer;
//   const ResultPage({
//     super.key,
//     required this.switchScreen, required this.selectedAnswer,
//   });

//   @override
//   State<ResultPage> createState() => _ResultPageState();
// }

// class _ResultPageState extends State<ResultPage> {
//   List<QuestionResult> selectedAnswers = [];

//   List<Map<String, Object>> getQuizSummary() {
//     final List<Map<String, Object>> summary = [];

//     for (var i = 0; i < selectedAnswers.length; i++) {
//       summary.add({
//         'question_number': i + 1,
//         'question_title': questions[i].questionTitle,
//         'correct_answer': questions[i].questionAnswers[0],
//         'selected_answer': selectedAnswers[i],
//         'color': selectedAnswers[i] == questions[i].questionAnswers[0]
//             ? Colors.greenAccent
//             : Colors.redAccent
//       });
//     }

//     return summary;
//   }

//   void getResult(){
//         for (var i = 0; i < widget.selectedAnswer.length; i++) {
//             selectedAnswers..add(
//                 QuestionResult(
//                 questionText: questions[i].questionTitle,
//                 selectedAnswer: widget.selectedAnswer[i],
//                 correctAnswer: questions[i].questionAnswers[0],
//                 explanation: questions[i].explanation,
//                 isCorrect: widget.selectedAnswer[i] == questions[i].questionAnswers[0],
//               ),
//             );
//         }

//         print(widget.selectedAnswer);

//   }

//   @override
//   void initState() {
//     super.initState();
//     getResult();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           "Results",
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
//         child: ListView.builder(
//           itemCount: selectedAnswers.length,
//           itemBuilder: (context, index) {
//             final question = selectedAnswers[index];
//             return ResultCard(
//               question: question,
//               onFavoriteToggle: () {
//                 setState(() {
//                   question.isFavorite = !question.isFavorite;
//                 });
//               },
//             );
//           },
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: widget.switchScreen,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.black,
//             padding: const EdgeInsets.symmetric(vertical: 16.0),
//           ),
//           child: const Text(
//             "Retake Quiz",
//             style: TextStyle(fontSize: 18, color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ResultCard extends StatelessWidget {
//   final QuestionResult question;
//   final VoidCallback onFavoriteToggle;

//   const ResultCard({
//     Key? key,
//     required this.question,
//     required this.onFavoriteToggle,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               question.questionText,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Your Answer: ${question.selectedAnswer}",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: question.isCorrect ? Colors.green : Colors.red,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               "Correct Answer: ${question.correctAnswer}",
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Explanation: ${question.explanation}",
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Align(
//               alignment: Alignment.centerRight,
//               child: IconButton(
//                 onPressed: onFavoriteToggle,
//                 icon: Icon(
//                   question.isFavorite ? Icons.favorite : Icons.favorite_border,
//                   color: question.isFavorite ? Colors.red : Colors.grey,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class QuestionResult {
//   final String questionText;
//   final String selectedAnswer;
//   final String correctAnswer;
//   final String explanation;
//   bool isCorrect;
//   bool isFavorite;

//   QuestionResult({
//     required this.questionText,
//     required this.selectedAnswer,
//     required this.correctAnswer,
//     required this.explanation,
//     required this.isCorrect,
//     this.isFavorite = false,
//   });
// }
