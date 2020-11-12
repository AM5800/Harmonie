import 'package:flutter/material.dart' hide Card;
import 'package:harmonie/study/study_vm.dart';

import 'card.dart';

abstract class ExerciseWidgetFactory {
  Widget tryGetWidgetForStudy(ExerciseVm vm);
}

abstract class CardFactory {
  Iterable<String> getSupportedCardTypes();

  Card tryGetCard(CardId id);

  Iterable<Card> getAllCards();
}

abstract class ExerciseVmFactory {
  ExerciseVm tryGetVmForStudy(Exercise exercise, StudyVm studyVm);
}
