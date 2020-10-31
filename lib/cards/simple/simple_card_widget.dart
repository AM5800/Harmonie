import 'package:flutter/material.dart' hide Card;
import 'package:harmonie/cards/simple/simple_card_vm.dart';
import 'package:harmonie/study/card_study_result.dart';

import '../abstract_factories.dart';
import '../card.dart';

class SimpleCardWidget extends StatelessWidget {
  final SimpleCardVm _vm;

  SimpleCardWidget(this._vm);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _vm.canShowAnswer,
      builder: (context, canShowAnswer, child) {
        if (canShowAnswer) {
          return Column(children: [
            Text(_vm.card.front),
            Text(_vm.card.back),
            FlatButton(
                onPressed: () => _vm.submitResult(CardStudyResult.AGAIN),
                child: Text("Again"))
          ]);
        }

        return Column(children: [
          Text(_vm.card.front),
          FlatButton(
              onPressed: () => _vm.showAnswer(), child: Text("Show Answer"))
        ]);
      },
    );
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
