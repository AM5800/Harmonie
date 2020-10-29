import 'dart:collection';

import 'package:flutter/material.dart';

abstract class CardPresenter {
  bool canHandle(Card card);

  bool canHandleId(CardId cardId);

  Widget present(Card card);
}

class SimpleCardPresenter implements CardPresenter {
  @override
  bool canHandle(Card card) {
    return canHandleId(card.id);
  }

  @override
  bool canHandleId(CardId cardId) {
    return cardId.cardType == SimpleCard.cardType;
  }

  @override
  Widget present(Card card) {
    assert(canHandle(card));
    // TODO: implement present
    throw UnimplementedError();
  }
}

abstract class CardFactory {
  Iterable<String> getSupportedCardTypes();

  Card tryGetCard(CardId id);
}

class CardId {
  final String id;
  final String cardType; // TODO: maybe this should be Type?

  CardId(this.id, this.cardType);
}

abstract class Card {
  CardId get id;
}

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
  }

  void _addCard(String id, String front, String back) {
    var card = SimpleCard(id, front, back);
    _cards[card.id] = card;
  }
}
