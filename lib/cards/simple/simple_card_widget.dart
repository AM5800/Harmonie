import 'package:flutter/material.dart' hide Card;
import 'package:harmonie/cards/simple/simple_card_vm.dart';

import '../abstract_factories.dart';
import '../card.dart';

class SimpleCardWidget extends StatelessWidget {
  final SimpleCardVm _vm;

  SimpleCardWidget(this._vm);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class SimpleCardWidgetFactory implements CardWidgetFactory {
  @override
  Widget tryGetStudyWidget(CardVm vm) {
    if (vm is SimpleCardVm) {
      return SimpleCardWidget(vm);
    }
    return null;
  }
}
