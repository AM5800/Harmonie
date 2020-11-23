import 'package:harmonie/cards/card.dart';
import 'package:harmonie/common/card_study_result.dart';
import 'package:tuple/tuple.dart';

class ChoiceExercise implements Exercise {
  final String front;
  final String frontUncovered;
  final String back;
  final List<Tuple2<String, CardStudyResult>> variants;

  ChoiceExercise(this.front, this.frontUncovered, this.back, this.variants);
}
