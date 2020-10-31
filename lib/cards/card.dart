class CardId {
  final String id;
  final String cardType; // TODO: maybe this should be Type?

  CardId(this.id, this.cardType);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardId &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          cardType == other.cardType;

  @override
  int get hashCode => id.hashCode ^ cardType.hashCode;
}

abstract class Card {
  CardId get id;
}

class CardVm {}
