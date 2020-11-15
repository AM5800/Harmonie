import 'package:flutter/material.dart';
import 'package:harmonie/cards/abstract_factories.dart';
import 'package:harmonie/cards/card.dart';
import 'package:harmonie/cards/exercises/rich_text_exercise_vm.dart';
import 'package:harmonie/common/self_result_widget.dart';

List<TextSpan> toSpans(String str, BuildContext context) {
  var currentIndex = 0;
  List<TextSpan> spans = [];

  final defaultText = DefaultTextStyle.of(context).style;
  final accentText = TextStyle(color: Theme.of(context).accentColor);

  final accentOpen = "<accent>";
  final accentEnd = "</accent>";

  while (currentIndex < str.length) {
    final accentPos = str.indexOf(accentOpen, currentIndex);

    if (accentPos == -1) {
      spans.add(TextSpan(
          text: str.substring(currentIndex, str.length), style: defaultText));
      break;
    }

    spans.add(TextSpan(
        text: str.substring(currentIndex, accentPos), style: defaultText));

    final accentEndPos = str.indexOf(accentEnd, accentPos + 1);

    if (accentEndPos == -1) {
      spans.add(TextSpan(
          text: str.substring(accentPos + accentOpen.length, str.length),
          style: accentText));
      break;
    }

    spans.add(TextSpan(
        text: str.substring(accentPos + accentOpen.length, accentEndPos),
        style: accentText));

    currentIndex = accentEndPos + accentEnd.length;
  }

  return spans;
}

RichText toRichText(String str, BuildContext context) {
  return RichText(
    text: TextSpan(children: toSpans(str, context)),
  );
}

Widget splitScreen(Widget topExpanded, Widget bottomBar) {
  return Container(
    width: double.infinity,
    child: Column(children: [
      Expanded(
        child: Container(
          alignment: Alignment.topLeft,
          child: Padding(padding: EdgeInsets.all(10), child: topExpanded),
        ),
      ),
      Container(
        width: double.infinity,
        child: bottomBar,
      )
    ]),
  );
}

class RichTextExerciseWidget extends StatelessWidget {
  final RichTextExerciseVm _vm;

  RichTextExerciseWidget(this._vm);

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
                SelfResultWidget(_vm.selfResultVm));
          }

          return splitScreen(
              toRichText(_vm.exercise.front, context),
              RaisedButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  onPressed: () => _vm.showAnswer(),
                  child: Text("SHOW ANSWER")));
        });
  }
}

class RichTextExerciseWidgetFactory implements ExerciseWidgetFactory {
  @override
  Widget tryGetWidgetForStudy(ExerciseVm vm) {
    if (vm is RichTextExerciseVm) {
      return RichTextExerciseWidget(vm);
    }

    return null;
  }
}
