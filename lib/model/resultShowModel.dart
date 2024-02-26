class ExamResult {
  final String id;
  final String exam;
  final String user;
  final String score;
  final String date;
  final String examId;
  final String title;
  final String examDate;
  final String subject;
  final String description;
  final String count;

  ExamResult({
    required this.id,
    required this.exam,
    required this.user,
    required this.score,
    required this.date,
    required this.examId,
    required this.title,
    required this.examDate,
    required this.subject,
    required this.description,
    required this.count,
  });

  factory ExamResult.fromJson(Map<String, dynamic> json) {
    return ExamResult(
      id: json['ExamResult_id'],
      exam: json['ExamResult_exam'],
      user: json['ExamResult_user'],
      score: json['ExamResult_score'],
      date: json['ExamResult_date'],
      examId: json['exam_id'],
      title: json['exam_title'],
      examDate: json['exam_date'],
      subject: json['exam_subject'],
      description: json['exam_description'],
      count: json['exam_count'],
    );
  }

  @override
  String toString() {
    return 'ExamResult{id: $id, exam: $exam, user: $user, score: $score, date: $date, examId: $examId, title: $title, examDate: $examDate, subject: $subject, description: $description, count: $count}';
  }
}
