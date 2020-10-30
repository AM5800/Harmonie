import 'dart:collection';

import '../abstract_factories.dart';
import '../card.dart';

class SimpleCard implements Card {
  static String cardType = "SimpleCard";

  final String front;
  final String back;
  final String _id;

  SimpleCard(this._id, this.front, this.back);

  @override
  CardId get id => CardId(_id, cardType);
}

class SimpleCardFactory implements CardFactory {
  Map<CardId, SimpleCard> _cards = LinkedHashMap();

  @override
  Card tryGetCard(CardId id) {
    return _cards[id];
  }

  @override
  Iterable<String> getSupportedCardTypes() {
    return [SimpleCard.cardType];
  }

  SimpleCardFactory() {
    _addCard("temp1", "Hallo", "Hello");
    _addCard("temp2", "Bye", "Tschuss");
  }

  void _addCard(String id, String front, String back) {
    var card = SimpleCard(id, front, back);
    _cards[card.id] = card;
  }
}
