import 'package:absoftexamination/model/questionModal.dart';
import 'package:absoftexamination/pages/examhome.dart';
import 'package:absoftexamination/pages/showQuestion.dart';
import 'package:absoftexamination/util/constant.dart';
import 'package:flutter/material.dart';

class QuizFinishPage extends StatefulWidget {
  final dynamic title, score, questionLen;
  final List questions;
  final List<QuestionChoice> questionsList;
  //final Map<int, dynamic> answer;
  final listQuestion;

  const QuizFinishPage(
      {super.key,
      required this.title,
      //required this.answer,
      this.listQuestion,
      this.score,
      this.questionLen,
      required this.questions,
      required this.questionsList});

  @override
  _QuizFinishPageState createState() => _QuizFinishPageState();
}

class _QuizFinishPageState extends State<QuizFinishPage> {
  int resultOfPresent = 0;

  int correct = 0;
  int incorrect = 0;
  double scorePercentage = 0.0;
  int? scorenum;
  int? questionLennum;
  // int score = 0;
  final nameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }

  @override
  void initState() {
    super.initState();
    print('Title: ${widget.title ?? "No title available"}');

    print('Score: ${widget.score ?? "Score not available"}');
    print(
        'Question length: ${widget.questionLen ?? "Question length not available"}');
    print(widget.questions);
    print(widget.questionsList);
    int? scorenum = int.tryParse(widget.score);
    int? questionLennum = widget.questionLen;

    if (scorenum != null && questionLennum != null) {
      scorePercentage = (scorenum * 100) / questionLennum;
      print(scorenum);
      print(questionLennum);
      print(scorePercentage);
      incorrect = questionLennum - scorenum;
      print(incorrect);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111A45),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.1, // Adjust the multiplier as needed
                  ),
                  Container(
                    width: double.infinity,
                    child: scorePercentage >= 80
                        //  widget.score != null &&
                        //         int.tryParse(widget.score)! >=80

                        ? Image.asset('assets/congratulate.png')
                        : Image.asset(
                            'assets/fail.png'), // Display fail image otherwise
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Your Score : ",
                        style: kHeadingTextStyleAppBar.copyWith(
                            fontSize: 24, color: Colors.white),
                      ),
                      Text(
                        '${widget.score} = ${scorePercentage}%',
                        style: kHeadingTextStyleAppBar.copyWith(
                          fontSize: 24,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "You have successfully completed",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.title,
                    style: kHeadingTextStyleAppBar.copyWith(
                        fontSize: 25, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Chip(
                          elevation: 5.0,
                          shadowColor: Colors.black54,
                          backgroundColor: Colors.grey[200],
                          label: Row(
                            children: <Widget>[
                              Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text("${widget.score} correct"),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      const SizedBox(
                        width: 20,
                      ),
                      Chip(
                          elevation: 5.0,
                          shadowColor: Colors.black54,
                          backgroundColor: Colors.grey[200],
                          label: Row(
                            children: <Widget>[
                              Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text("$incorrect incorrect"),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.06, // Adjust the multiplier as needed
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          elevation: MaterialStateProperty.all<double>(
                              0), // Remove elevation
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.transparent), // Remove overlay color
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(
                                color: Colors.blue,
                                width: 1.0), // Define border color and width
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowQuestionScreen(
                                        questions: widget.questions,
                                        questionsList: widget.questionsList,
                                      )));
                        },
                        child: Text('Show Question'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.04, // Adjust the multiplier as needed
                  ),
                  Expanded(
                    child: SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            elevation: MaterialStateProperty.all<double>(
                                0), // Remove elevation
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.transparent), // Remove overlay color
                            side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(
                                  color: Colors.blue,
                                  width: 1.0), // Define border color and width
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ExamHome()));
                          },
                          child: Text('Home'),

                          // title: 'Home',
                          // onTap: (){
                          //   Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (_)=>DashboardPage()), (e) => false);
                          // }
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //  _buildDialogSaveScore(){
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         backgroundColor: Colors.white,
  //         insetAnimationDuration:
  //         const Duration(milliseconds: 100),
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),),
  //         child: Container(
  //           padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
  //           width: double.infinity,
  //           height: 230,
  //           child: Column(
  //             children: <Widget>[
  //               Text('Save Score',
  //               style: kHeadingTextStyleAppBar.copyWith(
  //                 fontSize: 20
  //               ),),
  //             SizedBox(
  //               height: 15,
  //             ),
  //             SizedBox(
  //               width: double.infinity,
  //               child: TextField(
  //                 controller: nameController,
  //                 decoration: InputDecoration(
  //                   hintText: "Your Name",
  //                   prefixIcon: Icon(Icons.save),
  //                 ),
  //               ),
  //             ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               Align(alignment: Alignment.topLeft,
  //                 child: Row(
  //                   children: <Widget>[
  //                     Text("Your Score: ",style: TextStyle(
  //                       fontSize: 18
  //                     ),),
  //                     SizedBox(
  //                       width: 8,
  //                     ),
  //                     Text(score.toString(),style: kHeadingTextStyleAppBar.copyWith(
  //                       fontSize: 18,
  //                       color: Colors.red
  //                     ),),
  //                   ],
  //                 ),),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: <Widget>[
  //                   RaisedButton(
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(15),
  //                     ),
  //                     color: kItemSelectBottomNav,
  //                     onPressed: () {
  //                     },
  //                     child: Text('Cancel',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                     ),),
  //                   ),
  //                   FlatButton(
  //                       onPressed: ()  => _saveScore(),
  //                       child: Text("Save"),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  //  }
  //  _saveScore() async {
  //     var now =  DateTime.now();
  //    String datetime =  DateFormat.yMd().format(now);
  //    await Provider.of<ScoreProvider>(context,listen: false).addScore(nameController.text,
  //      widget.title, score,datetime ,correct,widget.listQuestion.length);
  //    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (_)=>DashboardPage()), (e) => false);
  //  }
}
