import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:harmonie/cards/exercises/rich_text_exercise_vm.dart';
import 'package:harmonie/cards/exercises/rich_text_exercise_widget.dart';
import 'package:harmonie/cards/simple_sentence/german/hardcoded_german_verbs.dart';
import 'package:harmonie/db/db.dart';
import 'package:harmonie/scheduling/scheduler.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'cards/abstract_factories.dart';
import 'study/study.dart';
import 'study/study_vm.dart';
import 'study/study_widget.dart';

void main() {
  final executor = (FlutterQueryExecutor.inDatabaseFolder(
    path: 'test.db',
    logStatements: true,
  ));
  final db = MoorDatabase(executor);
  final scheduler = Scheduler(db.attemptsDao);

  var factory = HardcodedGermanVerbFactory();
  var cards = factory.getAllCards().toList();

  var vmFactories = [RichTextExerciseVmFactory()];
  var widgetFactories = [RichTextExerciseWidgetFactory()];
  var study = Study(Queue.from(cards), scheduler);
  var studyVm = StudyVm(study, vmFactories);
  runApp(MyApp(studyVm, widgetFactories));
}

class MyApp extends StatelessWidget {
  final StudyVm _study;
  final List<ExerciseWidgetFactory> _widgetFactories;

  MyApp(this._study, this._widgetFactories);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonTheme: ButtonThemeData(
            height: 50,
          )),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: StudyWidget(_study, _widgetFactories),
    );
  }
}
