import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harmonie/study/self_result_vm.dart';

import 'card_study_result.dart';

class SelfResultWidget extends StatelessWidget {
  final SelfResultVm _vm;

  SelfResultWidget(this._vm);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _vm.buttons.map((vm) => _toWidget(vm, context)).toList(),
    );
  }

  Widget _toWidget(SelfResultButtonVm vm, BuildContext context) {
    var theme = Theme.of(context);

    switch (vm.result) {
      case CardStudyResult.AGAIN:
        return FlatButton(
            onPressed: vm.onClick,
            child: Text("Again"),
            color: theme.errorColor);
      case CardStudyResult.OK:
        return FlatButton(onPressed: vm.onClick, child: Text("Ok"));
      case CardStudyResult.GOOD:
        return FlatButton(
            onPressed: vm.onClick,
            child: Text("Good"),
            color: theme.accentColor);
    }
  }
}
