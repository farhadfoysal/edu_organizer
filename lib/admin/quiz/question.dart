class Question {
  // String q_id;
  // int id;
  final String questionTitle;
  final List<String> questionAnswers;
  final String explanation;
  final String source;
  const Question(this.questionTitle, this.questionAnswers, this.explanation, this.source);
  List<String> getShuffledAnswers() {
    final shuffledAnswers = List.of(questionAnswers);
    shuffledAnswers.shuffle();
    return shuffledAnswers;
  }
}