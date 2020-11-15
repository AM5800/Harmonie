import 'package:harmonie/cards/card.dart';
import 'package:harmonie/common/card_study_result.dart';
import 'package:harmonie/db/db.dart';

class Scheduler {
  final ScheduleDao _dao;

  Scheduler(this._dao);

  Future<Duration> estimateNextInterval(
      CardStudyResult result, CardId cardId) async {
    final lastAttempt = await _dao.getLastAttempt(cardId);

    // TODO: make all this stuff configurable once the algorithm is settled
    if (lastAttempt == null ||
        lastAttempt.attemptResult == CardStudyResult.AGAIN) {
      switch (result) {
        case CardStudyResult.AGAIN:
          return Duration(minutes: 5);
        case CardStudyResult.OK:
          return Duration(hours: 1);
        case CardStudyResult.GOOD:
          return Duration(days: 2);
      }

      throw Exception("Unreachable");
    }

    final lastInterval =
        lastAttempt.scheduledAt.difference(lastAttempt.attemptedAt);

    assert(!lastInterval.isNegative);

    return Duration(seconds: lastInterval.inSeconds * 2);
  }

  Future<DateTime> schedule(CardStudyResult result, CardId card) async {
    final interval = await estimateNextInterval(result, card);
    final nextDate = DateTime.now().add(interval);

    await _dao.upsert(card, nextDate, result);

    return nextDate;
  }

  List<CardId> getScheduled(DateTime untilDate) {
    return [];
    //return _dao.getUntilDate(untilDate);
  }
}
