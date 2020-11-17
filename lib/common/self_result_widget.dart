import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harmonie/common/self_result_vm.dart';

import 'card_study_result.dart';

String formatDuration(Duration duration) {
  if (duration.inDays > 30) return "${duration.inDays / 30} mo";
  if (duration.inDays > 0) return "${duration.inDays} d";
  if (duration.inHours > 0) return "${duration.inHours} h";
  if (duration.inMinutes > 10) return "${duration.inMinutes} min";
  if (duration.inMinutes > 5) return "< 10 min";
  return "< 1 min";
}

Widget makeButton(SelfResultButtonVm vm, String title, Color backgroundColor) {
  final foreground = TextStyle(color: Colors.white);
  return Expanded(
      child: FlatButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          onPressed: vm.onClick,
          child: Column(
            children: [
              Text(
                formatDuration(vm.dueInterval),
                style: foreground,
              ),
              Text(
                title,
                style: foreground,
              )
            ],
          ),
          color: backgroundColor));
}

class SelfResultWidget extends StatelessWidget {
  final SelfResultVm _vm;

  SelfResultWidget(this._vm);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SelfResultButtonVm>>(
      future: _vm.buttons,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                snapshot.data.map((vm) => _toWidget(vm, context)).toList(),
          );
        }

        return Container();
      },
    );
  }

  Widget _toWidget(SelfResultButtonVm vm, BuildContext context) {
    var theme = Theme.of(context);

    switch (vm.result) {
      case CardStudyResult.AGAIN:
        return makeButton(vm, "AGAIN", theme.errorColor);
      case CardStudyResult.OK:
        return makeButton(vm, "OK", Colors.grey);
      case CardStudyResult.GOOD:
        return makeButton(vm, "GOOD", theme.accentColor);
    }
  }
}
