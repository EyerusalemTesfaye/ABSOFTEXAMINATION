// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:absoftexamination/model/exam.dart';
import 'package:absoftexamination/model/questionModal.dart';
import 'package:absoftexamination/pages/showQuestion.dart';
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
  bool _isLoading = false;
  var choice;
  String selectedId = '';
  int currentQuestionIndex = 0;
  List<QuestionChoice> questionChoice = [];
  dynamic? score, title, questionLen;
  List<dynamic>? viewAnswerQuestion = [];
  @override
  void initState() {
    super.initState();
    questionLen = widget.questions.length;
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
        const SnackBar(
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
    if (currentQuestionIndex >= widget.questions.length - 1) {
      try {
        var requestBody =
            http.MultipartRequest('POST', Uri.parse(Api.resultView))
              ..fields['result_id'] = resultId!
              ..fields['token'] = token!;
        final response = await requestBody.send();
        final Map<String, dynamic> responseMap =
            json.decode(await response.stream.bytesToString());
        if (responseMap['header']['error'].toLowerCase() == 'false') {
          score = responseMap['data']['result']['score'];
          title = responseMap['data']['exam']['title'];
          final List<dynamic>? questions = responseMap['data']['questions'];

          if (questions != null) {
            viewAnswerQuestion = questions;

            // Process the list of questions
            List<QuestionChoice> questionChoices = [];
            final questionProvider =
                Provider.of<QuestionProvider>(context, listen: false);

            for (var question in questions) {
              var quest = question['question'];
              requestBody =
                  http.MultipartRequest('POST', Uri.parse(Api.questionView))
                    ..fields['question_id'] = quest;

              final respQuestionView = await requestBody.send();
              final Map<String, dynamic> respQuestionViewMap =
                  json.decode(await respQuestionView.stream.bytesToString());

              if (!mounted) return;

              if (respQuestionViewMap['header']['error'].toLowerCase() ==
                  'false') {
                final questionData = respQuestionViewMap['data']['question'];
                final choicesData = respQuestionViewMap['data']['choices'];
                print('questionData:');
                print(questionData['answer']);
                List<Choice> choicesList = [];

                choicesData.forEach((choice) {
                  choicesList.add(
                    Choice(
                      id: choice['id'],
                      text: choice['text'],
                    ),
                  );
                });

                final questionChoice = QuestionChoice(
                  id: questionData['id'],
                  text: questionData['text'],
                  answer: questionData['answer'],
                  choices: choicesList,
                );
                questionChoices.add(questionChoice);
              }
            }

            questionProvider.setQuestions(questionChoices);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => QuizFinishPage(
            //       title: title,
            //       score: score,
            //       questionLen: questionLen,
            //       questions: questions,
            //       questionsList: questionChoice,
            //     ),
            //     // ShowQuestionScreen(
            //     //     questions: questions, questionsList: questionChoices),
            //   ),
            // );
          } else {
            print('Error: Questions are null');
          }
        } else {
          print(
              'Failed to fetch result details: ${responseMap['header']['message']}');
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
      setState(() {
        _isLoading = true;
      });
      buildDialog(
        context,
        "Success",
        'You have finished the Quiz',
        DialogType.success,
        () {
          setState(() {
            _isLoading = true;
          });
          // Pop the dialog
          Navigator.pop(context);
          // Push to the QuizFinishPage with the desired parameters
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => QuizFinishPage(
                title: title,
                score: score,
                questionLen: questionLen,
                questions: viewAnswerQuestion ?? [],
                questionsList: questionChoice,
              ),
              // ShowQuestionScreen(
              //     questions: questions, questionsList: questionChoices),
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
    } finally {
      setState(() {
        _isLoading = false; // Stop loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questionChoice.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('No questions available'),
        ),
      );
    }
    var currentQuestion = questionChoice[currentQuestionIndex];

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/homeFrame.png'),
              fit: BoxFit.cover,
            )),
          ),
          Positioned(
            top: screenHeight * 0.05,
            left: 0,
            right: 0,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    buildDialog(
                        context,
                        "Warning!",
                        'Do you want to cancel this quiz? ',
                        DialogType.warning,
                        () => Navigator.pop(context),
                        () => null);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.08,
                ),
                Text(
                  widget.examTitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color(0xFF07193F)),
                ),
              ],
            ),
          ),
          Positioned(
              top: 150,
              right: 10,
              left: 20,
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 5, // Spread radius
                      blurRadius: 7, // Blur radius
                      offset: const Offset(
                          0, 3), // Offset in x and y axes from the shadow
                    ),
                  ],
                ),
              )),
          Positioned(
            top: 110,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: ClipPath(
              clipper: CircleClipper(),
              child: Container(
                width: 70,
                height: 70,
                color: Color(0xFF07193F),
                child: Center(
                  child: Text(
                    '${currentQuestionIndex + 1} /${questionLen}',
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 185,
              left: 60,
              right: 0,
              child: Text(
                currentQuestion.text,
                style: const TextStyle(fontSize: 18),
              )),
          // Positioned(
          //     top: 300,
          //     left: 20,
          //     right: 10,
          //     child: Container(
          //       height: 70,
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(10),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.grey.withOpacity(0.5), // Shadow color
          //             spreadRadius: 5, // Spread radius
          //             blurRadius: 7, // Blur radius
          //             offset: Offset(
          //                 0, 3), // Offset in x and y axes from the shadow
          //           ),
          //         ],
          //       ),
          //     )),

          Positioned(
            top: 290,
            left: 20,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                currentQuestion.choices.length,
                (index) {
                  var choice = currentQuestion.choices[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10), // Adjust vertical spacing as needed
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 5, // Spread radius
                            blurRadius: 7, // Blur radius
                            offset: const Offset(
                                0, 3), // Offset in x and y axes from the shadow
                          ),
                        ],
                      ),
                      child: CheckboxListTile(
                        title: Text(choice.text),
                        value: selectedChoice == choice.id.toString(),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null && value) {
                              _selectChoice(choice.id.toString());
                            } else {
                              selectedChoice = null;
                            }
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            right: 10,
            left: 20,
            child: SizedBox(
              width: double.infinity,
              height: 60, // Adjust the width as needed
              child: OutlinedButton(
                onPressed: () {
                  // Check if a choice has been selected
                  if (selectedChoice == null) {
                    // Show a snackbar message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('First, you have to select a choice.'),
                      ),
                    );
                  } else {
                    // Proceed to answer the question and navigate to the next question
                    _answerCurrentQuestion();
                    _navigateToNextQuestion();
                  }
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xFF07193F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  side: BorderSide(color: Colors.black),
                ),
                child: const Text(
                  'Answer',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          ),

          // WillPopScope(
          //   onWillPop: onBackPress,
          //   child: Scaffold(
          //     appBar: AppBar(
          //       backgroundColor: kItemSelectBottomNav,
          //       elevation: 0.0,
          //       leading: IconButton(
          //         onPressed: () {
          //           buildDialog(
          //               context,
          //               "Warning!",
          //               'Do you want to cancel this quiz? ',
          //               DialogType.warning,
          //               () => Navigator.pop(context),
          //               () => null);
          //         },
          //         icon: Icon(
          //           Icons.arrow_back,
          //           color: Colors.white,
          //         ),
          //       ),
          //       centerTitle: true,
          //       title: Column(
          //         children: <Widget>[
          //           SizedBox(height: 10),
          //           Text(
          //             widget.examTitle,
          //             style: kHeadingTextStyleAppBar.copyWith(
          //               color: Colors.white,
          //               fontSize: 18,
          //               letterSpacing: 1.0,
          //             ),
          //           ),
          //           const SizedBox(height: 20),
          //         ],
          //       ),
          //     ),
          //     body: Container(
          //       width: double.infinity,
          //       child: Stack(
          //         children: <Widget>[
          //           Text(
          //             '${widget.examSubject} Subject',
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.normal),
          //           ),
          //           ClipPath(
          //             clipper: MyClipper(),
          //             child: Container(
          //               height: 280,
          //               padding: const EdgeInsets.symmetric(
          //                   horizontal: 50, vertical: 50),
          //               width: MediaQuery.of(context).size.width,
          //               decoration: BoxDecoration(color: kItemSelectBottomNav),
          //             ),
          //           ),
          //           Column(
          //             children: <Widget>[
          //               SizedBox(height: 30),
          //               Column(
          //                 children: <Widget>[
          //                   SingleChildScrollView(
          //                     child: Row(
          //                       children: <Widget>[
          //                         SingleChildScrollView(
          //                           scrollDirection: Axis.horizontal,
          //                           physics: BouncingScrollPhysics(),
          //                         ),
          //                       ],
          //                     ),
          //                     scrollDirection: Axis.horizontal,
          //                   ),
          //                   const SizedBox(height: 30),
          //                   Padding(
          //                     padding: const EdgeInsets.symmetric(
          //                         horizontal: 20, vertical: 10),
          //                     child: Text(
          //                       currentQuestion.text,
          //                       style: kHeadingTextStyleAppBar.copyWith(
          //                           color: Colors.white, fontSize: 16),
          //                     ),
          //                   ),
          //                   SizedBox(height: 20),
          //                   Padding(
          //                     padding: EdgeInsets.symmetric(horizontal: 20),
          //                     child: Column(
          //                       children: <Widget>[
          //                         Container(
          //                           width: double.infinity,
          //                           padding: EdgeInsets.symmetric(
          //                               horizontal: 20, vertical: 20),
          //                           decoration: BoxDecoration(
          //                             color: Colors.white,
          //                             borderRadius: BorderRadius.circular(15),
          //                             boxShadow: [
          //                               BoxShadow(color: Colors.white),
          //                               BoxShadow(
          //                                   offset: Offset(1, 1),
          //                                   color: Colors.grey),
          //                               BoxShadow(color: Colors.white),
          //                             ],
          //                           ),
          //                           child: Column(
          //                             crossAxisAlignment:
          //                                 CrossAxisAlignment.start,
          //                             children: List.generate(
          //                               currentQuestion.choices.length,
          //                               (index) {
          //                                 var choice =
          //                                     currentQuestion.choices[index];
          //                                 return RadioListTile<String>(
          //                                   title: Text(choice.text),
          //                                   value: choice.id.toString(),
          //                                   groupValue: selectedChoice,
          //                                   onChanged: _selectChoice,
          //                                 );
          //                               },
          //                             ),
          //                           ),
          //                         ),
          //                         SizedBox(height: 20),
          // OutlinedButton(
          //   onPressed: () {
          //     // Check if a choice has been selected
          //     if (selectedChoice == null) {
          //       // Show a snackbar message
          //       ScaffoldMessenger.of(context)
          //           .showSnackBar(
          //         SnackBar(
          //           content: Text(
          //               'First, you have to select a choice.'),
          //         ),
          //       );
          //     } else {
          //       // Proceed to answer the question and navigate to the next question
          //       _answerCurrentQuestion();
          //       _navigateToNextQuestion();
          //     }
          //   },
          //   style: OutlinedButton.styleFrom(
          //     backgroundColor: Color(0xFF3559E0),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8.0),
          //     ),
          //     side: BorderSide(color: Colors.black),
          //   ),
          //   child: Text(
          //     'Answer',
          //     style: TextStyle(color: Colors.white),
          //   ),
          // )

          //                         // OutlinedButton(
          //                         //   onPressed: () {
          //                         //     _answerCurrentQuestion();
          //                         //     _navigateToNextQuestion();
          //                         //   },
          //                         //   style: OutlinedButton.styleFrom(
          //                         //     backgroundColor: Color(0xFF3559E0),
          //                         //     shape: RoundedRectangleBorder(
          //                         //       borderRadius: BorderRadius.circular(8.0),
          //                         //     ),
          //                         //     side: BorderSide(color: Colors.black),
          //                         //   ),
          //                         //   child: Text(
          //                         //     'Answer',
          //                         //     style: TextStyle(color: Colors.white),
          //                         //   ),
          //                         // )
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          if (_isLoading)
            const Opacity(
              opacity: 0.8,
              child: ModalBarrier(dismissible: false, color: Colors.black),
            ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
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

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
