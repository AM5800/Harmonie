import 'dart:collection';

import 'package:harmonie/cards/card.dart';
import 'package:harmonie/common/card_study_result.dart';
import 'package:harmonie/scheduling/scheduler.dart';

class Study {
  final Queue<Card> _cards;
  final Scheduler _scheduler;

  // TODO: ctor should accept iterable
  Study(this._cards, this._scheduler);

  Card get currentCard {
    assert(hasCard());
    return _cards.first;
  }

  void submitResult(CardStudyResult result) {
    assert(hasCard());
    Card card = currentCard;
    _cards.removeFirst();

    // TODO: async?
    _scheduler.schedule(result, card.id);

    if (result == CardStudyResult.AGAIN) _cards.add(card);
  }

  bool hasCard() {
    return _cards.isNotEmpty;
  }

  Future<Duration> estimateNextInterval(CardStudyResult result) {
    assert(hasCard());
    return _scheduler.estimateNextInterval(result, currentCard.id);
  }
}
