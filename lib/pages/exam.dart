import 'dart:convert';

import 'package:absoftexamination/pages/widget/awesomedialog.dart';
import 'package:absoftexamination/providers/examData.dart';
import 'package:absoftexamination/providers/userProvider.dart';
import 'package:absoftexamination/services/api.dart';
import 'package:absoftexamination/util/constant.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Exam extends StatefulWidget {
  final dynamic examTitle, examSubject, question;
  final List<dynamic> choices;
  final List<dynamic> questions;
  const Exam({
    super.key,
    this.examTitle,
    this.examSubject,
    required this.choices,
    required this.questions,
    this.question,
  });

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  String? selectedChoice;
  var choice;
  String selectedId = '';
  @override
  void initState() {
    super.initState();
    print('=====:${widget.examTitle}');
    print('gdsgagdgdg choices: ${widget.choices}');
  }

  void _Answer(String choice, String question) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String? token =
          userProvider.userData?['token']; // Extract token from userData
      // print('+Genet TTTT:${token}');
      var examDataProvider =
          Provider.of<ExamDataProvider>(context, listen: false);
      String? resultId = examDataProvider.examData?.id;
      print('+Genet TTTT:${resultId}');
      print(choice);
      print(question);
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
      }
    } catch (e) {
      print('Error fetching exam details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.examTitle,
                  style: kHeadingTextStyleAppBar.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // Text(
                //   "Difficult: ${widget.difficult}",
                //   style: kHeadingTextStyleAppBar.copyWith(
                //       fontSize: 15,
                //       fontWeight: FontWeight.normal,
                //       color: Colors.white
                //   ),
                // ),
              ],
            )),
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
              // SizedBox(
              //   height: 40,
              // ),
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
                  SizedBox(
                    height: 30,
                  ),
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
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          widget.question,
                          style: kHeadingTextStyleAppBar.copyWith(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
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
                                  BoxShadow(
                                    color: Colors.white,
                                  ),
                                  BoxShadow(
                                    offset: Offset(1, 1),
                                    color: Colors.grey,
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  for (choice in widget.choices)
                                    RadioListTile(
                                      groupValue: selectedChoice,
                                      activeColor: Colors.red,
                                      title: Text(choice['text']),
                                      // onChanged: (value) {
                                      //   setState(() {
                                      //     selectedChoice = value as String;
                                      //   });
                                      //   //value.selectRadio(e);
                                      // },
                                      onChanged: (value) {
                                        setState(() {
                                          selectedChoice = value
                                              as String; // Update selectedChoice with the selected ID
                                          selectedId = value
                                              as String; // Update selectedId with the selected ID
                                        });
                                      },
                                      value: choice['id'].toString(),
                                      //value: e,
                                    ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                _Answer(selectedId, choice['question']);
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Color(0xFF3559E0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                side: BorderSide(
                                  color: Colors.black,
                                ),
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
    // TODO: implement getClip
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

class HomeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
