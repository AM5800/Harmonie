import 'package:flutter/cupertino.dart';
import 'package:harmonie/cards/abstract_factories.dart';
import 'package:harmonie/cards/card.dart';
import 'package:harmonie/study/card_study_result.dart';
import 'package:harmonie/study/study_vm.dart';

import 'simple_card.dart';

class SimpleCardVm implements CardVm {
  final SimpleCard card;
  final StudyVm _study;

  void showAnswer() {
    canShowAnswer.value = true;
  }

  ValueNotifier<bool> canShowAnswer = ValueNotifier(false);

  void submitResult(CardStudyResult result) {
    _study.submitResult(result);
  }

  SimpleCardVm(this.card, this._study);
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
