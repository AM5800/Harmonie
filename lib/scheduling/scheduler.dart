import 'dart:math';

import 'package:harmonie/cards/card.dart';
import 'package:harmonie/common/card_study_result.dart';
import 'package:harmonie/db/db.dart';
import 'package:tuple/tuple.dart';

class DefaultSchedulingAlgorithm {
  static List<Duration> bins = [
    Duration(minutes: 5),
    Duration(hours: 1),
    Duration(days: 1),
    Duration(days: 2),
    Duration(days: 7),
    Duration(days: 30),
    Duration(days: 180)
  ];

  // TODO: cleaner signature and name
  Tuple2<Duration, int> attempt(
      CardStudyResult result, Attempt lastAttempt, DateTime now) {
    if (result == CardStudyResult.AGAIN) {
      return Tuple2(bins[0], 0);
    }

    // TODO: make all this stuff configurable once the algorithm is settled
    if (lastAttempt == null || lastAttempt.level == 0) {
      switch (result) {
        case CardStudyResult.AGAIN:
          return Tuple2(bins[0], 0);
        case CardStudyResult.OK:
          return Tuple2(bins[1], 1);
        case CardStudyResult.GOOD:
          return Tuple2(bins[3], 3);
      }

      throw Exception("Unreachable");
    }

    var nextLevel = lastAttempt.level;

    final isDue = now.compareTo(lastAttempt.scheduledAt) >= 0;
    if (!isDue) --nextLevel;

    if (result == CardStudyResult.OK)
      ++nextLevel;
    else if (result == CardStudyResult.GOOD)
      nextLevel += 2;
    else
      throw Exception("Should be unreachable");

    nextLevel = min(nextLevel, bins.length - 1);

    return Tuple2(bins[nextLevel], nextLevel);
  }
}

class Scheduler {
  final AttemptsDao _dao;
  final DefaultSchedulingAlgorithm _algorithm = DefaultSchedulingAlgorithm();

  Scheduler(this._dao);

  Future<Duration> estimateDueInterval(
      CardStudyResult result, CardId cardId) async {
    final lastAttempt = await _dao.getLastAttempt(cardId);

    return _algorithm.attempt(result, lastAttempt, DateTime.now()).item1;
  }

  Future<DateTime> schedule(CardStudyResult result, CardId cardId) async {
    final lastAttempt = await _dao.getLastAttempt(cardId);
    final tuple = _algorithm.attempt(result, lastAttempt, DateTime.now());

    final interval = tuple.item1;
    final newLevel = tuple.item2;

    final nextDate = DateTime.now().add(interval);

    await _dao.upsert(cardId, nextDate, newLevel);

    return nextDate;
  }

  List<CardId> getScheduled(DateTime untilDate) {
    return [];
    //return _dao.getUntilDate(untilDate);
  }
}
