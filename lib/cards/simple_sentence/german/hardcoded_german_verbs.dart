import 'dart:collection';
import 'dart:math';

import 'package:harmonie/cards/abstract_factories.dart';
import 'package:harmonie/cards/card.dart';
import 'package:harmonie/cards/exercises/rich_text_exercise.dart';
import 'package:harmonie/common/card_study_result.dart';

enum GermanCase { Nominativ, Accusativ, Dativ, Genitiv }

class VerbPrepositionSentence {
  final String de;
  final String en;
  final List<int> verbIndices;
  final List<int> prepositionIndices;

  VerbPrepositionSentence(
      this.de, this.en, this.verbIndices, this.prepositionIndices);

  static VerbPrepositionSentence _sichSpezialisieren1Auf =
      VerbPrepositionSentence(
          "Der Zoologe spezialisiert sich auf die Meeresbiologie",
          "The zoologist specializes in marine biology",
          [2, 3],
          [4]);

  static VerbPrepositionSentence _sichSpezialisieren2Auf = VerbPrepositionSentence(
      "Sie spezialisieren sich auf die Beschreibung Ihrer Produkte und Kategorienamen",
      "They are specialized in the description of your products and category names",
      [1, 2],
      [3]);

  static VerbPrepositionSentence _sichSpezialisieren3Auf = VerbPrepositionSentence(
      "Dadurch können Sie Ihr persönliches Profil entwickeln oder sich auf Schwerpunkte spezialisieren",
      "You can develop your personal profile, to specialize in your favour area",
      [8, 11],
      [9]);

  static List<VerbPrepositionSentence> sichSpezialisierenAuf = [
    _sichSpezialisieren1Auf,
    _sichSpezialisieren2Auf,
    _sichSpezialisieren3Auf
  ];

  static VerbPrepositionSentence _arbeitenAn = VerbPrepositionSentence(
      "Unsere Entwickler arbeiten an einer neue Version dieses machtigen Form-Baumeisters",
      "Our developers work on a new version of this powerful form builder",
      [2],
      [3]);

  static List<VerbPrepositionSentence> arbeitenAn = [
    _arbeitenAn,
  ];
}

class VerbMeaningCard implements Card {
  final String _id;
  final String _en;
  final List<VerbPrepositionSentence> _sentences;

  VerbMeaningCard(this._id, this._en, this._sentences);

  @override
  Exercise getExercise(Random random) {
    final sentence = _sentences[random.nextInt(_sentences.length)];

    final splitted = sentence.de.split(" ").toList();

    for (final index in sentence.verbIndices) {
      splitted[index] = "<accent>${splitted[index]}</accent>";
    }

    final String front = splitted.join(" ");
    final String back = "<accent>$_en</accent>\n${sentence.en}";

    return RichTextExercise(front, front, back, CardStudyResult.values);
  }

  @override
  CardId get id => CardId(_id, HardcodedGermanVerbFactory.Id);

  static VerbMeaningCard sichSpezialisierenAuf = VerbMeaningCard(
      "sich_spezialisieren",
      "To specialize in something",
      VerbPrepositionSentence.sichSpezialisierenAuf);

  static VerbMeaningCard arbeitenAn = VerbMeaningCard(
      "arbeiten", "To work on", VerbPrepositionSentence.arbeitenAn);
}

class VerbPrepositionCard implements Card {
  final String _id;
  final List<VerbMeaningCard> dependsOn;
  final List<VerbPrepositionSentence> _sentences;
  final GermanCase _case;

  VerbPrepositionCard(this._id, this.dependsOn, this._sentences, this._case);

  Exercise getExercise(Random random) {
    final sentence = _sentences[random.nextInt(_sentences.length)];

    final splitted1 = sentence.de.split(" ").toList();

    for (final index in sentence.verbIndices) {
      splitted1[index] = "<accent>${splitted1[index]}</accent>";
    }

    final splitted2 = splitted1.toList();

    for (final index in sentence.prepositionIndices) {
      splitted2[index] = "<accent>[preposition]</accent>";
    }

    final String front = splitted2.join(" ");
    final String frontUncovered = splitted1.join(" ");
    final String back = "${sentence.en}\n$_case";

    return RichTextExercise(
        front, frontUncovered, back, CardStudyResult.values);
  }

  @override
  CardId get id => CardId(_id, HardcodedGermanVerbFactory.Id);

  static VerbPrepositionCard sichSpezialisierenAuf = VerbPrepositionCard(
      "sich_spezialisieren_auf",
      [VerbMeaningCard.sichSpezialisierenAuf],
      VerbPrepositionSentence.sichSpezialisierenAuf,
      GermanCase.Accusativ);

  static VerbPrepositionCard arbeitenAn = VerbPrepositionCard(
      "arbeiten_an",
      [VerbMeaningCard.arbeitenAn],
      VerbPrepositionSentence.arbeitenAn,
      GermanCase.Dativ);
}

class HardcodedGermanVerbFactory implements CardFactory {
  static const String Id = "HardcodedGermanVerbFactory";
  final Map<CardId, Card> _cards = LinkedHashMap();

  HardcodedGermanVerbFactory() {
    _addCard(VerbMeaningCard.sichSpezialisierenAuf);
    _addCard(VerbMeaningCard.arbeitenAn);
    _addCard(VerbPrepositionCard.sichSpezialisierenAuf);
  }

  void _addCard(Card card) {
    _cards[card.id] = card;
  }

  @override
  Iterable<String> getSupportedCardTypes() {
    return [Id];
  }

  @override
  Card tryGetCard(CardId id) {
    return _cards[id];
  }

  @override
  Iterable<Card> getAllCards() {
    return _cards.values;
  }
}
