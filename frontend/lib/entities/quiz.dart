import 'question.dart';

class Quiz {
  final String id;
  final String moduleId;
  final List<Question> questions;
  final int passingScore;
  int? userScore;
  bool? isPassed;

  Quiz({
    required this.id,
    required this.moduleId,
    required this.questions,
    this.passingScore = 70,
    this.userScore,
    this.isPassed,
  });

  double get scorePercentage {
    if (userScore == null) return 0;
    return (userScore! / questions.length) * 100;
  }
}
