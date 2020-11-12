import 'package:harmonie/common/card_study_result.dart';
import 'package:harmonie/study/study_vm.dart';

class SelfResultButtonVm {
  final Function() onClick;
  final CardStudyResult result;

  SelfResultButtonVm(this.onClick, this.result);
}

class SelfResultVm {
  final List<SelfResultButtonVm> buttons;

  SelfResultVm(Iterable<CardStudyResult> values, StudyVm _studyVm)
      : buttons = values.map((v) => resultToVm(v, _studyVm)).toList();

  static SelfResultButtonVm resultToVm(CardStudyResult result, StudyVm study) {
    var onClick = () => study.submitResult(result);
    return SelfResultButtonVm(onClick, result);
  }

  static SelfResultVm fromEnum(
      Iterable<CardStudyResult> values, StudyVm study) {
    return SelfResultVm(values, study);
  }

  static SelfResultVm fromAllEnumValues(StudyVm study) {
    return fromEnum(CardStudyResult.values, study);
  }
}
