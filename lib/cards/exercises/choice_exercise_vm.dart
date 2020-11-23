import 'package:flutter/material.dart';
import 'package:harmonie/cards/abstract_factories.dart';
import 'package:harmonie/cards/card.dart';
import 'package:harmonie/cards/exercises/choice_exercise.dart';
import 'package:harmonie/study/study_vm.dart';

class ChoiceExerciseVm implements ExerciseVm {
  final ChoiceExercise exercise;
  final StudyVm _studyVm;

  ChoiceExerciseVm(this.exercise, this._studyVm);

  List<String> get variants => exercise.variants.map((e) => e.item1).toList();

  ValueNotifier<bool> canShowAnswer = ValueNotifier(false);
  int _selectedAnswer;

  void selectAnswer(int index) {
    final variants = exercise.variants;

    assert(index >= 0 && index < variants.length);

    _selectedAnswer = index;
    canShowAnswer.value = true;
  }

  void submit() {
    assert(canShowAnswer.value);
    assert(_selectedAnswer != null);
    assert(_selectedAnswer >= 0 && _selectedAnswer < variants.length);

    final result = exercise.variants[_selectedAnswer].item2;

    _studyVm.submitResult(result);
  }
}

class ChoiceExerciseVmFactory implements ExerciseVmFactory {
  @override
  ExerciseVm tryGetVmForStudy(Exercise exercise, StudyVm studyVm) {
    if (exercise is ChoiceExercise) {
      return ChoiceExerciseVm(exercise, studyVm);
    }

    return null;
  }
}

