import 'package:harmonie/cards/abstract_factories.dart';
import 'package:harmonie/cards/card.dart';

import 'simple_card.dart';

class SimpleCardVm implements CardVm {
  final SimpleCard card;

  SimpleCardVm(this.card);
}

class SimpleCardVmFactory implements CardVmFactory {
  @override
  CardVm tryGetVm(Card card) {
    if (card is SimpleCard) {
      return SimpleCardVm(card);
    }
    return null;
  }
}
