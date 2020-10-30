import 'package:harmonie/cards/abstract_factories.dart';
import 'package:harmonie/cards/card.dart';

import 'study.dart';

class StudyVm {
  final Study _study;
  final List<CardVmFactory> _vmFactories;

  StudyVm(this._study, this._vmFactories);

  CardVm get currentCardVm {
    assert(hasCard);

    Card card = _study.currentCard;

    var vm = _vmFactories
        .map((f) => f.tryGetVm(card))
        .where((vm) => vm != null)
        .single;

    return vm;
  }

  bool get hasCard {
    return _study.hasCard();
  }
}
