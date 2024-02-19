class QuestionChoice {
  final String id;
  final String text;
  final List<Choice> choices;

  QuestionChoice({
    required this.id,
    required this.text,
    required this.choices,
  });
  @override
  String toString() {
    return 'QuestionChoice(id: $id, text: $text, choices: $choices)';
  }
}

class Choice {
  final String id;
  final String text;

  Choice({
    required this.id,
    required this.text,
  });
  @override
  String toString() {
    return 'Choice(id: $id, text: $text)';
  }
}
