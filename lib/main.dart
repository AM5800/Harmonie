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
  final scheduler = Scheduler(db.scheduleDao);

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: StudyWidget(_study, _widgetFactories),
    );
  }
}
