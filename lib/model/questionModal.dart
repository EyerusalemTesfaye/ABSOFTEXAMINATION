class QuestionChoice {
  final String id;
  final String text;
  final String answer;
  final List<Choice> choices;

  QuestionChoice({
    required this.id,
    required this.text,
    required this.answer,
    required this.choices,
  });
  @override
  String toString() {
    return 'QuestionChoice(id: $id, text: $text,answer:$answer, choices: $choices)';
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
