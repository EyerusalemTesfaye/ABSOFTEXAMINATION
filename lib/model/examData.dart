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
  factory ExamData.fromJson(Map<String, dynamic> map) {
    return ExamData(
      id: map['id'],
      exam: map['exam'],
      user: map['user'],
      score: map['score'],
      date: map['date'],
    );
  }

  // Override toString method to provide a formatted string representation
  @override
  String toString() {
    return 'ExamData{id: $id, exam: $exam, user: $user, score: $score, date: $date}';
  }
}
