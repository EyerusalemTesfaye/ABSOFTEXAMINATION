import 'dart:convert';

import 'package:absoftexamination/model/exam.dart';
import 'package:absoftexamination/services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

// class ExamProvider extends ChangeNotifier {
//   List<Question> _questions = [];
//   //bool _isLoading = false;
//   String _error = '';

//   List<Question> get questions => _questions;
//   // bool get isLoading => _isLoading;
//   String get error => _error;

//   Future<void> fetchExamData() async {
//     try {
//       Response response = await get(Uri.parse(Api.showExamUrl));

//       if (response.statusCode == 200) {
//         Map<String, dynamic> data = jsonDecode(response.body);

//         if (data['header']['error'] == 'false') {
//           List<dynamic> questionsData = data['data'];

//           // Clear the existing questions before adding new ones
//           _questions.clear();

//           for (var questionData in questionsData) {
//             // Create a Question object using your model
//             Question question = Question.fromJson(questionData);

//             // Add the question to the list
//             _questions.add(question);
//           }
//         } else {
//           print('Error message: ${data['header']['message']}');
//           _error = data['header']['message']; // Set error message
//         }
//       } else {
//         print('Failed with status code: ${response.statusCode}');
//         _error =
//             'Failed with status code: ${response.statusCode}'; // Set error message
//       }
//     } catch (error) {
//       // Handle HTTP request error
//       print('Error fetching data: $error');
//       _error = 'Error fetching data: $error'; // Set error message
//     }

//     // Notify listeners that the data fetching is complete
//     notifyListeners();
//   }
// }
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ExamProvider extends ChangeNotifier {
  List<Question> _questions = [];
  String _error = '';

  List<Question> get questions => _questions;
  String get error => _error;

  Future<void> fetchExamData() async {
    try {
      final response = await http.get(Uri.parse(Api.showExamUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['header']['error'] == 'false') {
          final List<dynamic> questionsData = data['data'];
          _questions = questionsData
              .map((questionData) => Question.fromJson(questionData))
              .toList();
          _error = ''; // Clear error if there was any
        } else {
          _error = data['header']['message'];
        }
      } else {
        _error = 'Failed with status code: ${response.statusCode}';
      }
    } catch (error) {
      _error = 'Error fetching data: $error';
    }

    notifyListeners();
  }
}
