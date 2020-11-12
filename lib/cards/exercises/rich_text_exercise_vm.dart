import 'package:flutter/material.dart' hide Card;
import 'package:harmonie/cards/abstract_factories.dart';
import 'package:harmonie/cards/card.dart';
import 'package:harmonie/cards/exercises/rich_text_exercise.dart';
import 'package:harmonie/common/self_result_vm.dart';
import 'package:harmonie/study/study_vm.dart';

class RichTextExerciseVm implements ExerciseVm {
  final RichTextExercise exercise;
  final SelfResultVm selfResultVm;

  void showAnswer() {
    canShowAnswer.value = true;
  }

  ValueNotifier<bool> canShowAnswer = ValueNotifier(false);

  RichTextExerciseVm(this.exercise, StudyVm study)
      : selfResultVm = SelfResultVm.fromEnum(exercise.availableResults, study);
}

class RichTextExerciseVmFactory implements ExerciseVmFactory {
  @override
  ExerciseVm tryGetVmForStudy(Exercise exercise, StudyVm studyVm) {
    if (exercise is RichTextExercise) {
      return RichTextExerciseVm(exercise, studyVm);
    }

    return null;
  }
}
