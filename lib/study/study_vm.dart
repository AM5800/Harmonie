import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:harmonie/cards/abstract_factories.dart';
import 'package:harmonie/cards/card.dart';
import 'package:harmonie/common/card_study_result.dart';
import 'package:harmonie/study/study.dart';

class StudyVm {
  final Study _study;
  final List<ExerciseVmFactory> _vmFactories;

  ValueNotifier<ExerciseVm> currentExercise = ValueNotifier(null);

  StudyVm(this._study, this._vmFactories) {
    _nextCard();
  }

  void _nextCard() {
    if (!_study.hasCard()) {
      currentExercise.value = null;
      return;
    }

    Card card = _study.currentCard;
    final random = Random();
    Exercise exercise = card.getExercise(random);

    var vm = _vmFactories
        .map((f) => f.tryGetVmForStudy(exercise, this))
        .where((vm) => vm != null)
        .single;

    currentExercise.value = vm;
  }

  void submitResult(CardStudyResult result) {
    _study.submitResult(result);
    _nextCard();
  }

  Future<Duration> estimateDueInterval(CardStudyResult result) {
    return _study.estimateDueInterval(result);
  }
}
