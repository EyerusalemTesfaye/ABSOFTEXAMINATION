import 'dart:convert';

import 'package:absoftexamination/model/exam.dart';
import 'package:http/http.dart';

class Api {
  static const authUrl = 'https://exambackend.amanuel-girma.dev/Auth/login';
  static const authKey = 'token';
  static const userUrl = 'https://exambackend.amanuel-girma.dev/Users/register';
  static const showExamUrl = 'https://exambackend.amanuel-girma.dev/Exam/show';
  static const examDetail = 'https://exambackend.amanuel-girma.dev/Exam/detail';
  static const examStart =
      'https://exambackend.amanuel-girma.dev/ExamResult/save';
}

Future<void> getExam() async {
  try {
    Response response =
        await get(Uri.parse('https://exambackend.amanuel-girma.dev/Exam/show'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      if (data['header']['error'] == 'false') {
        List<dynamic> questions = data['data'];
        //final exams = questions;
        for (var questionData in questions) {
          // Create a Question object using your model
          Question question = Question.fromJson(questionData);

          // Print values for each question
          print('Title: ${question.title}');
          print('Subject: ${question.subject}');
          print('Count: ${question.count}');
          print('--------');
        }
      } else {
        print('Error message: ${data['header']['message']}');
      }
    } else {
      print('Failed with status code: ${response.statusCode}');
    }
  } catch (error) {
    // Handle HTTP request error
    print('Error fetching data: $error');
  }
}

Future<List<Question>> fetchQuestions() async {
  // Replace this with your actual API endpoint or data retrieval logic
  final response =
      await get(Uri.parse('https://exambackend.amanuel-girma.dev/Exam/show'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON and return the list of questions
    final List<dynamic> data = json.decode(response.body);
    final List<Question> questions =
        data.map((json) => Question.fromJson(json)).toList();
    return questions;
  } else {
    // If the server did not return a 200 OK response, throw an exception
    throw Exception('Failed to load questions');
  }
}
