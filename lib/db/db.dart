import 'package:harmonie/cards/card.dart';
import 'package:harmonie/common/card_study_result.dart';
import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'db.g.dart';

class Schedules extends Table {
  TextColumn get cardId => text()();

  DateTimeColumn get scheduledAt => dateTime()();

  DateTimeColumn get attemptedAt => dateTime()();

  IntColumn get attemptResult => integer()();

  @override
  Set<Column> get primaryKey => {cardId};
}

@UseMoor(tables: [Schedules], daos: [ScheduleDao])
class MoorDatabase extends _$MoorDatabase {
  MoorDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Schedules])
class ScheduleDao extends DatabaseAccessor<MoorDatabase>
    with _$ScheduleDaoMixin {
  ScheduleDao(MoorDatabase db) : super(db);

  Future upsert(CardId card, DateTime scheduleAt, CardStudyResult result) {
    final now = DateTime.now();
    final s = Schedule(
        cardId: card.toString(),
        scheduledAt: scheduleAt,
        attemptedAt: now,
        attemptResult: result.index);
    return into(schedules).insert(s, mode: InsertMode.insertOrReplace);
  }

  Future<Schedule> getLastAttempt(CardId cardId) async {
    final attempts = await (select(schedules)
          ..where((tbl) => tbl.cardId.equals(cardId.toString())))
        .get();

    assert(attempts.length <= 1);

    if (attempts.length == 0) return null;

    return attempts.first;
  }

// Future<List<Activity>> getActivities(FitDateTime date) {
//   return (select(activities)
//     ..where((tbl) =>
//         tbl.start.isBetweenValues(date.todayStart, date.todayEnd)))
//       .get();
// }
//
// Stream<List<Activity>> watchActivities(FitDateTime date) {
//   // TODO: do we need to take into account activities that cross day border?
//   return (select(activities)
//     ..where((tbl) =>
//         tbl.start.isBetweenValues(date.todayStart, date.todayEnd)))
//       .watch();
// }
//
// Future<int> upsertActivity(Activity activity) {
//   assert(activity.start.isUtc);
//   assert(activity.end.isUtc);
//   return into(activities).insert(activity, mode: InsertMode.insertOrReplace);
// }
//
// Future deleteActivity(int id) =>
//     (delete(activities)..where((tbl) => tbl.id.equals(id))).go();
}
