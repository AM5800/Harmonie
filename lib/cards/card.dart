class CardId {
  final String id;
  final String cardType; // TODO: maybe this should be Type?

  CardId(this.id, this.cardType);
}

abstract class Card {
  CardId get id;
}


class CardVm {

}