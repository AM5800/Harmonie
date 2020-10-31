import 'package:flutter/foundation.dart';
import 'package:harmonie/cards/abstract_factories.dart';
import 'package:harmonie/cards/card.dart';
import 'package:harmonie/study/card_study_result.dart';

import 'study.dart';

class StudyVm {
  final Study _study;
  final List<CardVmFactory> _vmFactories;

  ValueNotifier<CardVm> currentCardVm = ValueNotifier(null);

  StudyVm(this._study, this._vmFactories) {
    _nextCard();
  }

  void _nextCard() {
    if (!_study.hasCard()) {
      currentCardVm.value = null;
      return;
    }

    Card card = _study.currentCard;

    var vm = _vmFactories
        .map((f) => f.tryGetStudyVm(card, this))
        .where((vm) => vm != null)
        .single;

    currentCardVm.value = vm;
  }

  void submitResult(CardStudyResult result) {
    _study.submitResult(result);
    _nextCard();
  }
}
