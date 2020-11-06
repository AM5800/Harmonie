import 'package:flutter/cupertino.dart';
import 'package:harmonie/cards/abstract_factories.dart';
import 'package:harmonie/cards/card.dart';
import 'package:harmonie/study/self_result_vm.dart';
import 'package:harmonie/study/study_vm.dart';

import 'simple_card.dart';

class SimpleCardVm implements CardVm {
  final SimpleCard card;
  final SelfResultVm selfResultVm;

  void showAnswer() {
    canShowAnswer.value = true;
  }

  ValueNotifier<bool> canShowAnswer = ValueNotifier(false);

  SimpleCardVm(this.card, StudyVm study)
      : selfResultVm = SelfResultVm.fromAllEnumValues(study);
}

class SimpleCardVmFactory implements CardVmFactory {
  @override
  CardVm tryGetStudyVm(Card card, StudyVm studyVm) {
    if (card is SimpleCard) {
      return SimpleCardVm(card, studyVm);
    }
    return null;
  }
}
