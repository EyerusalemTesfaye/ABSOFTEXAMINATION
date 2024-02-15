class ExamData {
  final String id;
  final String exam;
  final String user;
  final int score;
  final int date;

  ExamData({
    required this.id,
    required this.exam,
    required this.user,
    required this.score,
    required this.date,
  });

  // Factory method to create an ExamData object from a JSON map
  factory ExamData.fromJson(Map<String, dynamic> json) {
    return ExamData(
      id: json['id'],
      exam: json['exam'],
      user: json['user'],
      score: json['score'],
      date: json['date'],
    );
  }
}
