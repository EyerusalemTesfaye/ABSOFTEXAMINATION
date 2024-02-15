import 'package:absoftexamination/model/examData.dart';
import 'package:flutter/material.dart';

class ExamDataProvider extends ChangeNotifier {
  ExamData? _examData;

  ExamData? get examData => _examData;

  void setExamData(Map<String, dynamic> json) {
    _examData = ExamData.fromJson(json['data']);
    notifyListeners();
  }
}
