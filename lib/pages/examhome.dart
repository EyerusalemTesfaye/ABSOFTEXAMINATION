// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:absoftexamination/model/exam.dart';
import 'package:absoftexamination/model/resultShowModel.dart';
import 'package:absoftexamination/pages/QuizBottomSheet.dart';
import 'package:absoftexamination/pages/home.dart';
import 'package:absoftexamination/pages/login.dart';
import 'package:absoftexamination/providers/question.dart';
import 'package:absoftexamination/providers/resultShow.dart';
import 'package:absoftexamination/providers/userProvider.dart';
import 'package:absoftexamination/services/api.dart';
import 'package:absoftexamination/util/router.dart';
import 'package:absoftexamination/util/shared_preferences_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ExamHome extends StatefulWidget {
  const ExamHome({Key? key}) : super(key: key);

  @override
  State<ExamHome> createState() => _ExamHomeState();
}

class _ExamHomeState extends State<ExamHome> {
  bool _isLoading = false; // Local loading state in ExamHome

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        _isLoading =
            true; // Set local isLoading to true before making the API call
      });
      // Use the provider to fetch data
      await context.read<ExamProvider>().fetchExamData();
    } finally {
      setState(() {
        _isLoading =
            false; // Set local isLoading to false after the API call is complete
      });
    }
  }

  void _examStart(String examId) async {
    print('Exam ID: $examId');
    // Print examId before sending request
    try {
      var requestBody = http.MultipartRequest('POST', Uri.parse(Api.examDetail))
        ..fields['exam_id'] = examId;

      final response = await requestBody.send();

      final Map<String, dynamic> responseMap =
          json.decode(await response.stream.bytesToString());

      if (responseMap['header']['error'].toLowerCase() == 'false') {
        print('Exam  fetched successfully');

        final res = responseMap['data'];
        print('res:***:${res}');
        print(res['title']);
        // ignore: use_build_context_synchronously
        _buildBottomSheet(context, res['title'], res['description'],
            res['subject'], res['id']);

        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (_) => Exam()));
      } else {
        print(
            'Failed to fetch exam details: ${responseMap['header']['message']}');
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to fetch exam details: ${responseMap['header']['message']}'),
          ),
        );
      }
    } catch (e) {
      print('Error fetching exam details: $e');
    }
  }

  Future<void> _results(BuildContext context) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String? token =
          userProvider.userData?['token']; // Extract token from userData

      var requestBody = http.MultipartRequest('POST', Uri.parse(Api.resultShow))
        ..fields['token'] = token!;
      final response = await requestBody.send();
      final Map<String, dynamic> responseMap =
          json.decode(await response.stream.bytesToString());
      if (responseMap['header']['error'].toLowerCase() == 'false') {
        // Convert response data to List<ExamResult>
        List<ExamResult> examResults = (responseMap['data'] as List<dynamic>)
            .map((dynamic item) => ExamResult.fromJson(item))
            .toList();

        // Update provider with examResults
        // ignore: use_build_context_synchronously
        context.read<ResultShowProvider>().setExamResults(examResults);

        print('result show fetched successful');
        print(responseMap['data']);

        // Navigate to ResultShowScreen
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, ResultShowScreen);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var examProvider = Provider.of<ExamProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : examProvider.error.isNotEmpty
              ? Center(
                  child: Text('Error: ${examProvider.error}'),
                )
              : Stack(
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
                      top: screenHeight * 0.039,
                      left: 0,
                      right: 0,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              //Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.25,
                          ),
                          const Text(
                            "Home",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          SizedBox(
                            width: screenWidth * 0.2,
                          ),
                          Expanded(
                            child: PopupMenuItem(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.menu,
                                  size: 30,
                                ),
                                onPressed: () {
                                  showMenu(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Adjust the value as needed
                                      side: const BorderSide(
                                          color: Color.fromARGB(255, 245, 245,
                                              245)), // Add border color if necessary
                                    ),
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    context: context,
                                    position: const RelativeRect.fromLTRB(
                                        82, 82, 0, 0),
                                    items: [
                                      PopupMenuItem(
                                        onTap: () => _results(context),
                                        value: 0,
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.list_alt,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Results',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, UserProfileScreen);
                                          //fetchData();
                                        },
                                        value: 1,
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.person_outline,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Profile',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        onTap: () {
                                          // fetchData();
                                        },
                                        value: 1,
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.perm_device_information,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'About Us',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        onTap: () async {
                                          await UserPreferences.removeToken();

                                          // ignore: use_build_context_synchronously
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => HomePage(),
                                            ),
                                          );
                                        },
                                        value: 2,
                                        child: const Column(
                                          children: [
                                            Divider(
                                              color: Color.fromARGB(
                                                  255, 62, 59, 59),
                                              thickness: 3.0,
                                              height: 10.0,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.logout,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Logout',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top + kToolbarHeight,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: examProvider.questions.length,
                              itemBuilder: (BuildContext context, int index) {
                                Question question =
                                    examProvider.questions[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        height: 180,
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/examlistBg.png'),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      Positioned(
                                        top: 20,
                                        left: 0,
                                        right: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 45),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                question.title,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 3,
                                                      horizontal: 8,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Text(
                                                      question.count,
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  const Text(
                                                    'Questions',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              TextButton(
                                                onPressed: () {
                                                  _examStart(question.id);
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    Color(0xFF2D54EF),
                                                  ),
                                                  shape: MaterialStateProperty
                                                      .all<OutlinedBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                ),
                                                child: const Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'Take',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    SizedBox(width: 35),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}

_buildBottomSheet(BuildContext context, String cardTitle, String description,
    String subjects, String id) {
  // showModalBottomSheet(
  //   context: context,
  //   builder: (BuildContext context) {
  //     return SizedBox(
  //       height: 400,
  //       child: Center(
  //         child: Text('$cardTitle'),
  //       ),
  //     );
  //   },
  // );

  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      context: context,
      builder: (_) {
        return QuizBottomSheet(
          title: cardTitle,
          subTitle: description,
          subjects: subjects,
          examId: id,
        );
      });
}
//}

class HomeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    final firstCurve = Offset(0, size.height - 20);
    final lastCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(
      firstCurve.dx,
      firstCurve.dy,
      lastCurve.dx,
      lastCurve.dy,
    );
    final secondfirstCurve = Offset(0, size.height - 20);
    final secondlastCurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(
      secondfirstCurve.dx,
      secondfirstCurve.dy,
      secondlastCurve.dx,
      secondlastCurve.dy,
    );
    final thirdfirstCurve = Offset(size.width, size.height - 20);
    final thirdlastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(
      thirdfirstCurve.dx,
      thirdfirstCurve.dy,
      thirdlastCurve.dx,
      thirdlastCurve.dy,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
