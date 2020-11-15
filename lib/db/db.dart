import 'package:harmonie/cards/card.dart';
import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'db.g.dart';

class Attempts extends Table {
  TextColumn get cardId => text()();

  DateTimeColumn get scheduledAt => dateTime()();

  DateTimeColumn get attemptedAt => dateTime()();

  IntColumn get level => integer()();

  @override
  Set<Column> get primaryKey => {cardId};
}

@UseMoor(tables: [Attempts], daos: [AttemptsDao])
class MoorDatabase extends _$MoorDatabase {
  MoorDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Attempts])
class AttemptsDao extends DatabaseAccessor<MoorDatabase>
    with _$AttemptsDaoMixin {
  AttemptsDao(MoorDatabase db) : super(db);

  Future upsert(CardId card, DateTime scheduleAt, int level) {
    final now = DateTime.now();
    final s = Attempt(
        cardId: card.toString(),
        scheduledAt: scheduleAt,
        attemptedAt: now,
        level: level);
    return into(attempts).insert(s, mode: InsertMode.insertOrReplace);
  }

  Future<Attempt> getLastAttempt(CardId cardId) async {
    final cardAttempts = await (select(attempts)
          ..where((tbl) => tbl.cardId.equals(cardId.toString())))
        .get();

    assert(cardAttempts.length <= 1);

    if (cardAttempts.length == 0) return null;

    return cardAttempts.first;
  }
}
