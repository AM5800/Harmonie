import 'package:harmonie/cards/card.dart';
import 'package:harmonie/common/card_study_result.dart';

class RichTextExercise implements Exercise {
  final String front;
  final String frontUncovered;
  final String back;
  final List<CardStudyResult> availableResults;

  RichTextExercise(
      this.front, this.frontUncovered, this.back, this.availableResults);
}
