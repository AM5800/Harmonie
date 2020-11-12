import 'dart:math';

class CardId {
  final String id;
  final String factoryId; // TODO: maybe this should be Type?

  CardId(this.id, this.factoryId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardId &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          factoryId == other.factoryId;

  @override
  int get hashCode => id.hashCode ^ factoryId.hashCode;
}

abstract class Exercise {}

abstract class ExerciseVm {}

abstract class Card {
  CardId get id;

  Exercise getExercise(Random random);
}

class CardVm {}
