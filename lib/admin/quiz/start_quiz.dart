import 'package:class_organizer/admin/quiz/quiz_page.dart';
import 'package:flutter/material.dart';

class StartQuiz extends StatelessWidget {
  final void Function() switchScreen;
  StartQuiz(this.switchScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // App Logo or Icon (optional)
              Icon(
                Icons.quiz,
                size: 100,
                color: Colors.black,
              ),
              SizedBox(height: 32),
              // Title
              Text(
                "Welcome to the Quiz",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              // Description
              Text(
                "Test your knowledge and see how much you know. Tap the button below to start the quiz!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 32),
              // Start Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the QuizPage
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => StartQuiz(),
                  //   ),
                  // );
                  switchScreen();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Start Quiz",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
