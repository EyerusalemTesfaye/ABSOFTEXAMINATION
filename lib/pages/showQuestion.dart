// ignore_for_file: avoid_print

import 'package:absoftexamination/model/questionModal.dart';
import 'package:absoftexamination/providers/questionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowQuestionScreen extends StatefulWidget {
  final List questions;
  final List<QuestionChoice> questionsList;

  //final List<Map<String, dynamic>> questions;

  // final Map<int, dynamic> answer;

  const ShowQuestionScreen({
    super.key,
    required this.questions,
    required this.questionsList,
  });

  @override
  State<ShowQuestionScreen> createState() => _ShowQuestionScreenState();
}

class _ShowQuestionScreenState extends State<ShowQuestionScreen> {
  List<QuestionChoice> questionChoice = [];
  int currentQuestionIndex = 0;
  @override
  void initState() {
    super.initState();
    print('widget.questions:${widget.questions}');

    // print('selectedChoiceId:${selectedChoiceId}');
    print('questions.length:${widget.questions.length}');
    print('widget.questionsList:${widget.questionsList}');
    var questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    if (questionProvider.questions.isNotEmpty) {
      questionChoice = questionProvider.questions;
      print('Question data from provider: $questionChoice');
      print('Number of questions: ${questionChoice.length}');
      print('First question: ${questionChoice}');
    } else {
      print('No questions available');
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
//var currentQuestion = questionChoice[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 46, 47, 83),
        title: Text(
          "Show Question",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white, // Change the color of the back button
          onPressed: () {
            // Define the action when the back button is pressed
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: <Widget>[
              //for (var question in widget.questions)
              ListView.builder(
                itemCount: widget.questionsList.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  // var question = widget.questions[index];
                  final question = widget.questionsList[index];
                  var selectedChoiceId =
                      int.parse(widget.questions[index]['choice']);
                  // bool correct = question.correctAnswer == widget.answer[index];
                  print('selectedChoiceId:$selectedChoiceId');
                  var isQuestionStateTrue =
                      widget.questions[index]['state'] == 'true';
                  print(isQuestionStateTrue);
                  print(widget.questions[index]['state']);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(4, 4),
                              blurRadius: 10,
                              color: Colors.grey.withOpacity(.5),
                            ),
                            BoxShadow(
                              offset: const Offset(-3, 0),
                              blurRadius: 15,
                              color: Color(0xffb8bfce).withOpacity(.4),
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              question.text,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            // subtitle: Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: question.choices.map((choice) {
                            //     // Find the state of the current choice
                            //     var choiceState = choice.id == question.answer;

                            //     // Determine the text color based on the choice state
                            //     Color textColor =
                            //         choiceState ? Colors.green : Colors.black;

                            //     return Text(
                            //       choice.text,
                            //       style: TextStyle(color: textColor),
                            //     );
                            //   }).toList(),
                            // ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: question.choices.map((choice) {
                                //var isCorrectAnswer =
                                //  choice.id == question.answer;

                                // var isSelectedChoice =
                                //choice.id == selectedChoiceId;

                                // bool isQuestionStateTrue =
                                // widget.questions[index]['state'] == 'false';

                                Color textColor = question.answer == choice.id
                                    ? Colors.green
                                    : (int.parse(choice.id) ==
                                                selectedChoiceId &&
                                            int.parse(question.answer) !=
                                                selectedChoiceId
                                        ? Colors.red
                                        : Colors.black);
                                //  (isSelectedChoice
                                //
                                //     : (isCorrectAnswer
                                //          Colors.green
                                //         : Colors.black))
                                // : (isCorrectAnswer
                                //      Colors.green
                                //     : Colors.black);

                                return Text(
                                  choice.text,
                                  style: TextStyle(color: textColor),
                                );
                              }).toList(),
                            ),

                            // subtitle: Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: question.choices.map((choice) {
                            //     // Check if the choice ID matches the selected choice ID
                            //     var isSelectedChoice = choice.id ==
                            //         widget.questions[index]['choice'];
                            //     var choiceState = choice.id == question.answer;
                            //     // Determine the text color based on the question state and choice ID
                            //     // if(!choiceState)
                            //     Color textColor =
                            //         widget.questions[index]['state'] == false &&
                            //                 isSelectedChoice
                            //             ? Colors.red
                            //             : Colors.black;

                            //     return Text(
                            //       choice.text,
                            //       style: TextStyle(color: textColor),
                            //     );
                            //   }).toList(),
                            // ),
                          ),

                          // ListTile(
                          //   title: Text(question.text),
                          //   subtitle: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: question.choices
                          //         .map((choice) => Text(choice.text))
                          //         .toList(),
                          //   ),
                          // ),
                          // ListTile(
                          //   title: Text(question.text),
                          //   subtitle: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: question.choices.map((choice) {
                          //       // Find the state of the current choice
                          //       var choiceState = widget.questions.firstWhere(
                          //         (q) => q['choice'] == choice.id,
                          //         orElse: () =>
                          //             null, // Return null if no element is found
                          //       )?['state'];

                          //       // Determine the text color based on the choice state
                          //       Color textColor = choiceState == 'true'
                          //           ? Colors.green
                          //           : Colors.red;

                          //       return Text(
                          //         choice.text,
                          //         style: TextStyle(color: textColor),
                          //       );
                          //     }).toList(),
                          //   ),
                          // ),

                          const SizedBox(
                            height: 15,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: <Widget>[
                          //     Padding(
                          //       child: Text("Answer: "),
                          //       padding: EdgeInsets.only(top: 5),
                          //     ),
                          //     Padding(
                          //       child: Text(
                          //         'ghhhh',
                          //         // widget.answer[index] == null
                          //         //     ? ""
                          //         //     : widget.answer[index],
                          //         style: TextStyle(
                          //           fontWeight: FontWeight.bold,
                          //           // color: correct ? Colors.green : Colors.red,
                          //         ),
                          //       ),
                          //       padding: EdgeInsets.only(top: 5),
                          //     ),
                          //     const SizedBox(
                          //       width: 10,
                          //     ),
                          //     Padding(
                          //       child: Icon(Icons.check_circle
                          //           // correct ? Icons.check_circle : Icons.close,
                          //           // color: correct ? Colors.green : Colors.red,
                          //           ),
                          //       padding: EdgeInsets.only(top: 2),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(
                            height: 5,
                          ),
                          // correct
                          //     ? Container()
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: <Widget>[
                          //     Text("Correct: "),
                          //     Text(
                          //       'lldflldf',
                          //       // HtmlUnescape()
                          //       //     .convert(question.correctAnswer),
                          //       style: TextStyle(
                          //           color: Colors.black,
                          //           fontWeight: FontWeight.bold),
                          //     )
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
