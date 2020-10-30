import 'package:flutter/material.dart';
import 'package:harmonie/cards/abstract_factories.dart';

import 'study_vm.dart';

class StudyWidget extends StatelessWidget {
  final StudyVm _studyVm;
  final List<CardWidgetFactory> _cardWidgetFactories;

  StudyWidget(this._studyVm, this._cardWidgetFactories);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test study"),
      ),
    );
  }
}
