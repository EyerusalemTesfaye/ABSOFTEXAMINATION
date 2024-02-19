import 'package:absoftexamination/model/exam.dart';
import 'package:absoftexamination/model/questionModal.dart';
import 'package:flutter/material.dart';

class QuestionProvider extends ChangeNotifier {
  List<QuestionChoice> _questions = [];

  List<QuestionChoice> get questions => _questions;

  void setQuestions(List<QuestionChoice> questions) {
    _questions = questions;

    notifyListeners();
    print('kdkjkdjkjd hey:$questions');
  }
}
