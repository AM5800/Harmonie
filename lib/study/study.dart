import 'dart:collection';

import 'package:harmonie/cards/card.dart';
import 'package:harmonie/common/card_study_result.dart';

class Study {
  final Queue<Card> _cards;

  // TODO: ctor should accept iterable
  Study(this._cards);

  Card get currentCard {
    assert(hasCard());
    return _cards.first;
  }

  void submitResult(CardStudyResult result) {
    // TODO: handle result
    assert(hasCard());
    Card card = currentCard;
    // TODO: do something with the card
    _cards.removeFirst();
  }

  bool hasCard() {
    return _cards.isNotEmpty;
  }
}
