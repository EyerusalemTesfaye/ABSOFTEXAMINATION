import 'package:absoftexamination/model/resultShowModel.dart';
import 'package:flutter/material.dart';

class ResultShowProvider extends ChangeNotifier {
  List<ExamResult> _examResults = [];

  List<ExamResult> get examResults => _examResults;

  void setExamResults(List<ExamResult> examResults) {
    _examResults = examResults;
    print('jhjjhhy  ===========');
    print(_examResults);

    notifyListeners();
  }
}
