class Question {
  String id;
  String title;
  String date;
  String subject;
  String description;
  String count;

  Question({
    required this.id,
    required this.title,
    required this.date,
    required this.subject,
    required this.description,
    required this.count,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      subject: json['subject'],
      description: json['description'],
      count: json['count'],
    );
  }
}
