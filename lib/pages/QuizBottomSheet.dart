import 'dart:convert';

import 'package:absoftexamination/pages/exam.dart';
import 'package:absoftexamination/pages/examhome.dart';
import 'package:absoftexamination/providers/auth.dart';
import 'package:absoftexamination/providers/userProvider.dart';
import 'package:absoftexamination/services/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class QuizBottomSheet extends StatefulWidget {
  final String title;
  final String subTitle;
  final String subjects;
  final String examId;

  const QuizBottomSheet(
      {required this.title,
      required this.subTitle,
      required this.subjects,
      required this.examId})
      : super();

  @override
  _QuizBottomSheetState createState() => _QuizBottomSheetState();
}

class _QuizBottomSheetState extends State<QuizBottomSheet> {
  final globalKey = GlobalKey<ScaffoldState>();

  void _examDetail(String examId) async {
    print('Exam ID: $examId'); // Print examId before sending request
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String? token =
          userProvider.userData?['token']; // Extract token from userData
      print('+++++++++:${token}');
      var requestBody = http.MultipartRequest('POST', Uri.parse(Api.examStart))
        ..fields['exam_id'] = examId
        ..fields['token'] = token ?? '';

      final response = await requestBody.send();

      final Map<String, dynamic> responseMap =
          json.decode(await response.stream.bytesToString());

      if (responseMap['header']['error'].toLowerCase() == 'false') {
        final res = responseMap['data'];
        print('Exam details fetched successfully');
        print('genet:${res}');

        requestBody = http.MultipartRequest('POST', Uri.parse(Api.examView))
          ..fields['exam_id'] = examId;
        final respExamView = await requestBody.send();
        final Map<String, dynamic> respExamViewMap =
            json.decode(await respExamView.stream.bytesToString());
        if (respExamViewMap['header']['error'].toLowerCase() == 'false') {
          final List<dynamic> questions = respExamViewMap['data']['questions'];

          for (var question in questions) {
            // Access each
            var quest = question['question'];
            print('Question: ${quest}');
            requestBody =
                http.MultipartRequest('POST', Uri.parse(Api.questionView))
                  ..fields['question_id'] = quest;
            final respQuestionView = await requestBody.send();
            final Map<String, dynamic> respQuestionViewMap =
                json.decode(await respQuestionView.stream.bytesToString());
            if (respQuestionViewMap['header']['error'].toLowerCase() ==
                'false') {
              print('******:${respQuestionViewMap['data']['question']}');
            }
          }
          final resExamView = respExamViewMap['data']['exam'];
          final examViewTitle = respExamViewMap['data']['exam']['title'];
          print('exam view fetched successfully');
          print('exam view====:${resExamView}');
          print(examViewTitle);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => Exam(
                      examTitle: respExamViewMap['data']['exam']['title'],
                      examSubject: respExamViewMap['data']['exam']
                          ['subject'])));
        }
      } else {
        print(
            'Failed to fetch exam details: ${responseMap['header']['message']}');
      }
    } catch (e) {
      print('Error fetching exam details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('${widget.subjects} Subject'),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(widget.subTitle),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF3559E0)),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white) // Change to your desired color
                    ),
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  _examDetail(widget.examId);
                },
                child: Text(
                  "Start Exam",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
