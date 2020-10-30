import 'package:flutter/material.dart' hide Card;

import 'card.dart';

abstract class CardWidgetFactory {
  Widget tryGetStudyWidget(CardVm vm);
}

abstract class CardFactory {
  Iterable<String> getSupportedCardTypes();

  Card tryGetCard(CardId id);
}

abstract class CardVmFactory {
  // TODO: unify interfaces of factories
  CardVm tryGetVm(Card card);
}
