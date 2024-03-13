import 'dart:convert';

import 'package:absoftexamination/model/questionModal.dart';
import 'package:absoftexamination/pages/examhome.dart';
import 'package:absoftexamination/pages/home.dart';
import 'package:absoftexamination/pages/showQuestion.dart';
import 'package:absoftexamination/providers/questionProvider.dart';
import 'package:absoftexamination/providers/resultShow.dart';
import 'package:absoftexamination/providers/userProvider.dart';
import 'package:absoftexamination/services/api.dart';
import 'package:absoftexamination/util/router.dart';
import 'package:absoftexamination/util/shared_preferences_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:absoftexamination/model/resultShowModel.dart';
import 'package:http/http.dart' as http;
//import 'package:absoftexamination/provider/result_show_provider.dart'; // Import your provider file

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<QuestionChoice> questionsList = [];
  void _resultDetail(String result_id) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String? token = userProvider.userData?['token'];

      var requestBody = http.MultipartRequest('POST', Uri.parse(Api.resultView))
        ..fields['result_id'] = result_id
        ..fields['token'] = token ?? '';

      final response = await requestBody.send();
      final Map<String, dynamic> responseMap =
          json.decode(await response.stream.bytesToString());

      if (responseMap['header']['error'].toLowerCase() == 'false') {
        final List<dynamic>? questions = responseMap['data']['questions'];

        if (questions != null) {
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ShowQuestionScreen(
                  questions: questions, questionsList: questionChoices),
            ),
          );
        } else {
          print('Error: Questions are null');
        }
      } else {
        print(
            'Failed to fetch result details: ${responseMap['header']['message']}');
      }
    } catch (e) {
      print('Error during result detail fetch: $e');
    }
  }

//   void _resultDetail(String result_id) async {
//     print(result_id);

//     try {
//       var userProvider = Provider.of<UserProvider>(context, listen: false);
//       String? token =
//           userProvider.userData?['token']; // Extract token from userData
//       print('+++++++++:${token}');
//       var requestBody = http.MultipartRequest('POST', Uri.parse(Api.resultView))
//         ..fields['result_id'] = result_id
//         ..fields['token'] = token ?? '';

//       final response = await requestBody.send();

//       final Map<String, dynamic> responseMap =
//           json.decode(await response.stream.bytesToString());

//       if (responseMap['header']['error'].toLowerCase() == 'false') {
//         final List<dynamic> questions = responseMap['data']['questions'];
//         final res = responseMap['data'];
//         print('result details fetched successfully');
//         print(res);
//         final questionProvider =
//             Provider.of<QuestionProvider>(context, listen: false);

//         for (var question in questions) {
//           // Access each question
//           print('Total questions: ${questions.length}');
//           var quest = question['question'];

//           // Send a request for each question
//           requestBody =
//               http.MultipartRequest('POST', Uri.parse(Api.questionView))
//                 ..fields['question_id'] = quest;

//           final respQuestionView = await requestBody.send();
//           final Map<String, dynamic> respQuestionViewMap =
//               json.decode(await respQuestionView.stream.bytesToString());

//           // Check if the widget is still mounted before proceeding
//           if (!mounted) return;

//           // Print the response for each question
//           print('Response for question: $quest');
//           print(respQuestionViewMap);

//           if (respQuestionViewMap['header']['error'].toLowerCase() == 'false') {
//             final questionData = respQuestionViewMap['data']['question'];
//             final choicesData = respQuestionViewMap['data']['choices'];

//             print('Question: ${questionData['text']}');
//             print('Choices: $choicesData');

// // Create a list to hold Choice objects
//             List<Choice> choicesList = [];

//             // Convert choicesData to List<Choice>
//             choicesData.forEach((choice) {
//               choicesList.add(
//                 Choice(
//                   id: choice['id'],
//                   text: choice['text'],
//                 ),
//               );
//             });

//             // Create a QuestionChoice object
//             final questionChoice = QuestionChoice(
//               id: questionData['id'],
//               text: questionData['text'],
//               choices: choicesList,
//             );
//             questionsList.add(questionChoice);
//             print('pleassssssssssss:$questionChoice');
//           }
//         }
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (_) => ShowQuestionScreen(
//                       questions: questions,
//                     )));
//         questionProvider.setQuestions(questionsList);

//         print('result detail view fetched successfully');
//       } else {
//         print(
//             'Failed to fetch result details: ${responseMap['header']['message']}');
//       }
//     } catch (e) {}
//   }

  @override
  Widget build(BuildContext context) {
    var showResult = Provider.of<ResultShowProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Color(0xFF4042C9)),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    // {
                    //   Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (_) => LoginPage(),
                    //       ));
                    // },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: screenWidth * 0.18,
                ),
                Text(
                  "Exam Result ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  width: screenWidth * 0.15,
                ),
                Expanded(
                  child: PopupMenuItem(
                    child: IconButton(
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showMenu(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Adjust the value as needed
                            side: BorderSide(
                                color: Colors
                                    .grey), // Add border color if necessary
                          ),
                          context: context,
                          position: RelativeRect.fromLTRB(82, 82, 0, 0),
                          items: [
                            PopupMenuItem(
                              child: Text('Exams'),
                              onTap: () {
                                Navigator.pushNamed(context, ExamHomeScreen);
                              },
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: Text('Logout'),
                              onTap: () async {
                                await UserPreferences.removeToken();

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => HomePage(),
                                  ),
                                );
                              },
                              value: 2,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListView.builder(
                        itemCount: showResult.examResults.length,
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          ExamResult result = showResult.examResults[index];
                          print(
                              'Number of questions: ${showResult.examResults.length}'); // Add this line

                          return InkWell(
                            onTap: () => {},
                            child: Card(
                              child: Container(
                                height: screenHeight * 0.2,
                                width: screenWidth * 0.94,
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            color: Colors.green, width: 5))),
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment
                                  // .start, // Align text to the left

                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      result.title,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Score: ${result.score}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: screenHeight * 0.013),
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          _resultDetail(result.id);
                                        },
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor:
                                              Color.fromARGB(255, 77, 77, 79),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          side: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Text(
                                          'View',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
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
