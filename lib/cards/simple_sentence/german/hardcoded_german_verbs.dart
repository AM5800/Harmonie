import 'dart:collection';
import 'dart:math';

import 'package:harmonie/cards/abstract_factories.dart';
import 'package:harmonie/cards/card.dart';
import 'package:harmonie/cards/exercises/rich_text_exercise.dart';
import 'package:harmonie/common/card_study_result.dart';

class VerbPrepositionSentence {
  final String de;
  final String en;
  final List<int> verbIndices;
  final List<int> prepositionIndices;

  VerbPrepositionSentence(
      this.de, this.en, this.verbIndices, this.prepositionIndices);

  static VerbPrepositionSentence sichSpezialisieren1 = VerbPrepositionSentence(
      "Der Zoologe spezialisiert sich auf die Meeresbiologie",
      "The zoologist specializes in marine biology",
      [2, 3],
      [4]);

  static VerbPrepositionSentence sichSpezialisieren2 = VerbPrepositionSentence(
      "Sie spezialisieren sich auf die Beschreibung Ihrer Produkte und Kategorienamen",
      "They are specialized in the description of your products and category names",
      [1, 2],
      [3]);

  static VerbPrepositionSentence sichSpezialisieren3 = VerbPrepositionSentence(
      "Dadurch können Sie Ihr persönliches Profil entwickeln oder sich auf Schwerpunkte spezialisieren",
      "You can develop your personal profile, to specialize in your favour area",
      [8, 11],
      [9]);

  static List<VerbPrepositionSentence> sichSpezialisieren = [
    sichSpezialisieren1,
    sichSpezialisieren2,
    sichSpezialisieren3
  ];
}

class SichSpezialisieren implements Card {
  @override
  Exercise getExercise(Random random) {
    final sentences = VerbPrepositionSentence.sichSpezialisieren;
    final sentence = sentences[random.nextInt(sentences.length)];

    final splitted = sentence.de.split(" ").toList();

    for (final index in sentence.verbIndices) {
      splitted[index] = "<accent>${splitted[index]}</accent>";
    }

    final String front = splitted.join(" ");
    final String back =
        "<accent>to specialize in something</accent>\n${sentence.en}";

    return RichTextExercise(front, front, back, CardStudyResult.values);
  }

  @override
  CardId get id => CardId("sich_spezialisieren", HardcodedGermanVerbFactory.Id);
}

class SichSpezialisierenFuer implements Card {
  // TODO: dependency

  Exercise getExercise(Random random) {
    final sentences = VerbPrepositionSentence.sichSpezialisieren;
    final sentence = sentences[random.nextInt(sentences.length)];

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
    final String back =
        "<accent>to specialize in something</accent>\nAccusative\n${sentence.en}";

    return RichTextExercise(front, frontUncovered, back, CardStudyResult.values);
  }

  @override
  CardId get id =>
      CardId("sich_spezialisieren_fuer", HardcodedGermanVerbFactory.Id);
}

class HardcodedGermanVerbFactory implements CardFactory {
  static final String Id = "HardcodedGermanVerbFactory";
  final Map<CardId, Card> _cards = LinkedHashMap();

  HardcodedGermanVerbFactory() {
    _addCard(SichSpezialisieren());
    _addCard(SichSpezialisierenFuer());
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
