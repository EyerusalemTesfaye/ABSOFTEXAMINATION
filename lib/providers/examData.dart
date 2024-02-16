import 'package:absoftexamination/model/examData.dart';
import 'package:flutter/material.dart';

class ExamDataProvider extends ChangeNotifier {
  ExamData? _examData;

  ExamData? get examData => _examData;
//result id
  void setExamData(Map<String, dynamic> data) {
    _examData = ExamData.fromJson(data);
    print('exam data provider: ${_examData}');
    //print(_examData);
    notifyListeners();
  }
}
