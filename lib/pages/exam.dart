import 'dart:convert';
import 'package:absoftexamination/model/questionModal.dart';
import 'package:absoftexamination/pages/soreResult.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:absoftexamination/providers/examData.dart';
import 'package:absoftexamination/providers/questionProvider.dart';
import 'package:absoftexamination/providers/userProvider.dart';
import 'package:absoftexamination/services/api.dart';
import 'package:absoftexamination/util/constant.dart';
import 'package:absoftexamination/pages/widget/awesomedialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Exam extends StatefulWidget {
  final dynamic examTitle, examSubject;
  //final List<dynamic> choices;
  final List<dynamic> questions;

  const Exam({
    super.key,
    this.examTitle,
    this.examSubject,
    // required this.choices,
    required this.questions,
    //this.question,
  });

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  String? selectedChoice;
  var choice;
  String selectedId = '';
  int currentQuestionIndex = 0;
  List<QuestionChoice> questionChoice = [];
  dynamic? score, title,questionLen;
  @override
  void initState() {
    super.initState();
    questionLen= widget.questions.length;
    print('=====:${widget.examTitle}');
    print('gdsgagdgdg question: ${questionLen}');
    print(widget.questions[currentQuestionIndex]['question']);
    var questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    if (questionProvider.questions.isNotEmpty) {
      questionChoice = questionProvider.questions;
      print('Question data from provider: $questionChoice');
      print('Number of questions: ${questionChoice.length}');
      print('First question: ${questionChoice[currentQuestionIndex].text}');
    } else {
      print('No questions available');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No question Available'),
          ),
        );
    }
  }

  void _selectChoice(String? choiceId) {
    setState(() {
      selectedChoice = choiceId;
      if (choiceId != null) {
        selectedId = choiceId;
      }
    });
  }

  void _answerCurrentQuestion() {
    if (selectedId != null &&
        widget.questions[currentQuestionIndex]['question'] != null) {
      _Answer(selectedId!, widget.questions[currentQuestionIndex]['question']!);
    } else {
      print('Selected ID or question ID is null');
    }
  }

  Future<void> _viewResult(String token, String resultId) async {
    if (currentQuestionIndex == widget.questions.length - 1) {
      try {
        var requestBody =
            http.MultipartRequest('POST', Uri.parse(Api.resultView))
              ..fields['result_id'] = resultId!
              ..fields['token'] = token!;
        final response = await requestBody.send();
        final Map<String, dynamic> responseMap =
            json.decode(await response.stream.bytesToString());
        if (responseMap['header']['error'].toLowerCase() == 'false') {
          final res = responseMap['data'];
          score = responseMap['data']['result']['score'];
          title = responseMap['data']['exam']['title'];

          print('result fetched successful');
          print(title);
        }
      } catch (e) {}
    }
  }

  void _navigateToNextQuestion() {
    // Check if there are more questions
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        // Increment the current question index
        currentQuestionIndex++;

        // Reset selectedChoice and selectedId for the new question
        selectedChoice = null;
        selectedId = '';
      });
    } else {
      // _viewResult();
      // buildDialog(context, "Success", 'You have finished the Quiz ',
      //     DialogType.success, () => Navigator.pop(context), () => QuizFinishPage(title: 'kkj', answer: {},));

      buildDialog(
        context,
        "Success",
        'You have finished the Quiz',
        DialogType.success,
        () {
          // Pop the dialog
          Navigator.pop(context);
          // Push to the QuizFinishPage with the desired parameters
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizFinishPage(title: title, score: score, questionLen:questionLen),
            ),
          );
        },
        () => null,
      );
    }
  }

  void _Answer(String choice, String question) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String? token = userProvider.userData?['token'];
      var examDataProvider =
          Provider.of<ExamDataProvider>(context, listen: false);
      String? resultId = examDataProvider.examData?.id;

      var requestBody = http.MultipartRequest('POST', Uri.parse(Api.answerPost))
        ..fields['choice'] = choice
        ..fields['result_id'] = resultId!
        ..fields['question'] = question
        ..fields['token'] = token!;
      final response = await requestBody.send();
      final Map<String, dynamic> responseMap =
          json.decode(await response.stream.bytesToString());
      if (responseMap['header']['error'].toLowerCase() == 'false') {
        final res = responseMap['data'];
        print(res);
        print('Answer fetched successful');
        _viewResult(token, resultId);
      }
    } catch (e) {
      print('Error fetching exam details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questionChoice.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text('No questions available'),
        ),
      );
    }
    var currentQuestion = questionChoice[currentQuestionIndex];

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kItemSelectBottomNav,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              buildDialog(
                  context,
                  "Warning!",
                  'Do you want to cancel this quiz? ',
                  DialogType.warning,
                  () => Navigator.pop(context),
                  () => null);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                widget.examTitle,
                style: kHeadingTextStyleAppBar.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        body: Container(
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Text(
                '${widget.examSubject} Subject',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 280,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: kItemSelectBottomNav),
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  Column(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Row(
                          children: <Widget>[
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                            ),
                          ],
                        ),
                        scrollDirection: Axis.horizontal,
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          currentQuestion.text,
                          style: kHeadingTextStyleAppBar.copyWith(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(color: Colors.white),
                                  BoxShadow(
                                      offset: Offset(1, 1), color: Colors.grey),
                                  BoxShadow(color: Colors.white),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  currentQuestion.choices.length,
                                  (index) {
                                    var choice = currentQuestion.choices[index];
                                    return RadioListTile<String>(
                                      title: Text(choice.text),
                                      value: choice.id.toString(),
                                      groupValue: selectedChoice,
                                      onChanged: _selectChoice,
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            OutlinedButton(
                              onPressed: () {
                                _answerCurrentQuestion();
                                _navigateToNextQuestion();
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Color(0xFF3559E0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                side: BorderSide(color: Colors.black),
                              ),
                              child: Text(
                                'Answer',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPress() {
    return buildDialog(context, "Warning!", 'Do you want to cancel this quiz? ',
        DialogType.warning, () => Navigator.pop(context, true), () => null);
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
