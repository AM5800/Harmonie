import 'package:harmonie/common/card_study_result.dart';
import 'package:harmonie/study/study_vm.dart';

class SelfResultButtonVm {
  final Function() onClick;
  final CardStudyResult result;
  final Duration repeatIn;

  SelfResultButtonVm(this.onClick, this.result, this.repeatIn);
}

class SelfResultVm {
  final Future<List<SelfResultButtonVm>> buttons;

  SelfResultVm(Iterable<CardStudyResult> values, StudyVm _studyVm)
      : buttons = Future.wait(values.map((v) => resultToVm(v, _studyVm)));

  static Future<SelfResultButtonVm> resultToVm(
      CardStudyResult result, StudyVm study) async {
    final onClick = () => study.submitResult(result);
    final repeatIn = await study.estimateNextInterval(result);
    return SelfResultButtonVm(onClick, result, repeatIn);
  }

  static SelfResultVm fromEnum(
      Iterable<CardStudyResult> values, StudyVm study) {
    return SelfResultVm(values, study);
  }

  static SelfResultVm fromAllEnumValues(StudyVm study) {
    return fromEnum(CardStudyResult.values, study);
  }
}
