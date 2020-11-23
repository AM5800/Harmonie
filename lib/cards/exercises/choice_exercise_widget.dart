import 'package:flutter/material.dart';
import 'package:harmonie/cards/abstract_factories.dart';
import 'package:harmonie/cards/card.dart';
import 'package:harmonie/cards/exercises/choice_exercise_vm.dart';
import 'package:harmonie/cards/exercises/rich_text_exercise_widget.dart';

class ChoiceExerciseWidget extends StatelessWidget {
  final ChoiceExerciseVm _vm;

  ChoiceExerciseWidget(this._vm);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _vm.canShowAnswer,
        builder: (context, canShowAnswer, child) {
          if (canShowAnswer) {
            return splitScreen(
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  toRichText(_vm.exercise.frontUncovered, context),
                  Divider(),
                  toRichText(_vm.exercise.back, context),
                ]),
                // TODO: extract this flat button somewhere?
                makeButton("CONTINUE", _vm.submit));
          }

          return splitScreen(
              toRichText(_vm.exercise.front, context),
              Column(
                children: makeButtons(_vm.variants),
              ));
        });
  }

  FlatButton makeButton(String text, Function onPressed) {
    return FlatButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        onPressed: onPressed,
        color: Colors.grey,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ));
  }

  List<Widget> makeButtons(List<String> variants) {
    List<Widget> result = [];
    for (var i = 0; i < variants.length; i++) {
      result.add(makeButton(variants[i], () => _vm.selectAnswer(i)));
    }

    return result;
  }
}

class ChoiceExerciseWidgetFactory implements ExerciseWidgetFactory {
  @override
  Widget tryGetWidgetForStudy(ExerciseVm vm) {
    if (vm is ChoiceExerciseVm) {
      return ChoiceExerciseWidget(vm);
    }

    return null;
  }
}
