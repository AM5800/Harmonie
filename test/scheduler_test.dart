import 'package:harmonie/cards/card.dart';
import 'package:harmonie/common/card_study_result.dart';
import 'package:harmonie/db/db.dart';
import 'package:harmonie/scheduling/scheduler.dart';
import 'package:test/test.dart';

void main() {
  final algorithm = DefaultSchedulingAlgorithm();
  final now = DateTime.now();
  final hourAgo = now.subtract(Duration(hours: 1));
  final twoHoursAgo = now.subtract(Duration(hours: 2));
  final inAHour = now.add(Duration(hours: 1));
  final id = CardId("hello", "world");

  final makeNonDueAttempt = (level) => Attempt(
      cardId: id.toString(),
      scheduledAt: inAHour,
      level: level,
      attemptedAt: hourAgo);

  test("Schedule in 2 days on first good attempt", () {
    final tuple = algorithm.attempt(CardStudyResult.GOOD, null, now);
    expect(tuple.item1, Duration(days: 2));
    expect(tuple.item2, 3);
  });

  test("Failure resets progress", () {
    final lastAttempt = Attempt(
        cardId: id.toString(),
        scheduledAt: hourAgo,
        attemptedAt: twoHoursAgo,
        level: 0);
    final tuple = algorithm.attempt(CardStudyResult.OK, lastAttempt, now);
    expect(tuple.item1, Duration(hours: 1));
    expect(tuple.item2, 1);
  });

  test("Check oks sequence", () {
    final tuple1 = algorithm.attempt(CardStudyResult.OK, null, now);
    expect(tuple1.item1, Duration(hours: 1));
    expect(tuple1.item2, 1);

    final attempt2 = Attempt(
        cardId: id.toString(),
        scheduledAt: now.add(tuple1.item1),
        attemptedAt: now,
        level: tuple1.item2);

    final tuple2 =
        algorithm.attempt(CardStudyResult.OK, attempt2, attempt2.scheduledAt);
    expect(tuple2.item1, Duration(days: 1));
    expect(tuple2.item2, 2);

    // TODO: continue sequence
  });

  test("Again on not due resets progress", () {
    final tuple =
        algorithm.attempt(CardStudyResult.AGAIN, makeNonDueAttempt(2), now);
    expect(tuple.item2, 0);
  });

  test("Ok on not due does not progress", () {
    final tuple1 =
        algorithm.attempt(CardStudyResult.OK, makeNonDueAttempt(2), now);
    expect(tuple1.item2, 2);

    final tuple2 =
        algorithm.attempt(CardStudyResult.OK, makeNonDueAttempt(0), now);
    expect(tuple2.item2, 1);
  });

  test("Good on not due incs progress", () {
    final tuple1 =
        algorithm.attempt(CardStudyResult.GOOD, makeNonDueAttempt(4), now);
    expect(tuple1.item2, 5);

    final tuple2 =
        algorithm.attempt(CardStudyResult.GOOD, makeNonDueAttempt(0), now);
    expect(tuple2.item2, 3);
  });
}
