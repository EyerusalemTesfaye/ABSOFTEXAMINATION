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
        _buildBottomSheet(context, res['title'], res['description'],
            res['subject'], res['id']);

        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (_) => Exam()));
      } else {
        print(
            'Failed to fetch exam details: ${responseMap['header']['message']}');
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
        context.read<ResultShowProvider>().setExamResults(examResults);

        print('result show fetched successful');
        print(responseMap['data']);

        // Navigate to ResultShowScreen
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
          ? Container(
              height: screenHeight,
              width: screenWidth,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/splash.png'),
                fit: BoxFit.cover,
              )),
            )
          // Center(
          //     child: CircularProgressIndicator(),
          //   )
          : examProvider.error.isNotEmpty
              ? Center(
                  child: Text('Error: ${examProvider.error}'),
                )
              : Container(
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
                          Image(
                            width: 50,
                            height: 50,
                            image: AssetImage('assets/quizer_logo.png'),
                          ),
                          // ColorFiltered(
                          //   colorFilter:
                          //       ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          //   child: Image(
                          //     width: 50,
                          //     height: 50,
                          //     image: AssetImage('assets/quizer_logo.png'),
                          //   ),
                          // ),

                          SizedBox(
                            width: screenWidth * 0.2,
                          ),
                          Text(
                            "Select Subject",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(
                            width: screenWidth * 0.1,
                          ),
                          Expanded(
                            child: PopupMenuItem(
                              child: IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  showMenu(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Adjust the value as needed
                                      side: BorderSide(
                                          color: const Color.fromARGB(
                                              255,
                                              245,
                                              245,
                                              245)), // Add border color if necessary
                                    ),
                                    context: context,
                                    position:
                                        RelativeRect.fromLTRB(82, 82, 0, 0),
                                    items: [
                                      PopupMenuItem(
                                        child: Row(
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
                                        onTap: () => _results(context),
                                        value: 0,
                                      ),
                                      PopupMenuItem(
                                        child: Row(
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
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, UserProfileScreen);
                                          //fetchData();
                                        },
                                        value: 1,
                                      ),
                                      PopupMenuItem(
                                        child: Row(
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
                                        onTap: () {
                                          fetchData();
                                        },
                                        value: 1,
                                      ),
                                      PopupMenuItem(
                                        child: Column(
                                          children: [
                                            Divider(
                                              color: const Color.fromARGB(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                                  itemCount: examProvider.questions.length,
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Question question =
                                        examProvider.questions[index];
                                    print(
                                        'Number of questions: ${examProvider.questions.length}'); // Add this line

                                    return InkWell(
                                      onTap: () => {},
                                      child: Card(
                                        child: Container(
                                          height: screenHeight * 0.2,
                                          width: screenWidth * 0.94,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  left: BorderSide(
                                                      color: Colors.green,
                                                      width: 5))),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                question.title,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                '[${question.count}] ${question.subject} Subject Questions',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              SizedBox(
                                                  height: screenHeight * 0.013),
                                              Expanded(
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    _examStart(question.id);
                                                  },
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        Color(0xFF3559E0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    side: BorderSide(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Take Exam',
                                                    style: TextStyle(
                                                        color: Colors.white),
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

// : SingleChildScrollView(
//     child: Column(
//       children: [
//         ClipPath(
//           clipper: HomeClipper(),
//           child: Container(
//             width: screenWidth,
//             height: screenHeight *
//                 0.25, // Adjust the height as needed
//             color: Color(0xFF4042C9),
//             padding: EdgeInsets.all(0),
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: screenHeight *
//                       0.07, // Adjust the top position as needed
//                   right: 0,
//                   left: 0,
//                   child: Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => LoginPage(),
//                             ),
//                           );
//                         },
//                         icon: Icon(
//                           Icons.arrow_back,
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(
//                         width: screenWidth *
//                             0.18, // Adjust the width as needed
//                       ),
//                       Text(
//                         'Select Subject',
//                         style: TextStyle(
//                             color: Colors.white, fontSize: 18),
//                       ),
//                       SizedBox(
//                         width: screenWidth *
//                             0.15, // Adjust the width as needed
//                       ),
//                       PopupMenuItem(
//                         child: IconButton(
//                           icon: Icon(
//                             Icons.more_horiz,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {
//                             showMenu(
//                               shape: Border.all(),
//                               context: context,
//                               position: RelativeRect.fromLTRB(
//                                   82, 82, 0, 0),
//                               items: [
//                                 PopupMenuItem(
//                                   child: Center(
//                                     child: Text('Results'),
//                                   ),
//                                   onTap: () => print('fgfddfg'),
//                                   value: 0,
//                                 ),
//                                 PopupMenuItem(
//                                   child: Center(
//                                     child: Text('Exams'),
//                                   ),
//                                   onTap: () {
//                                     fetchData();
//                                   },
//                                   value: 1,
//                                 ),
//                                 PopupMenuItem(
//                                   child: Center(
//                                     child: Text('Logout'),
//                                   ),
//                                   onTap: () =>
//                                       Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (_) => LoginPage(),
//                                     ),
//                                   ),
//                                   value: 2,
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SingleChildScrollView(
//           child: Stack(
//             children: [
//               Column(
//                 children: [
//                   Positioned(
//                     top: screenHeight * 0.50,
//                     right: 0,
//                     left: 0,
//                     child: Column(
//                       children: [
//                         Card(
//                           elevation: 2,
//                           child: ClipPath(
//                             child: Container(
//                               height: screenHeight * 0.25,
//                               width: screenWidth * 0.94,
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                 children: [
//                                   for (Question question
//                                       in examProvider.questions)
//                                     Column(
//                                       children: [
//                                         Text(
//                                           question.title,
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight:
//                                                 FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(height: 10),
//                                         Text(
//                                             '[${question.count}] ${question.subject} Subject Questions'),
//                                         SizedBox(height: 10),
//                                         OutlinedButton(
//                                           onPressed: () {
//                                             _buildBottomSheet(
//                                               context,
//                                               question.title,
//                                               question
//                                                   .description,
//                                             );
//                                           },
//                                           style: OutlinedButton
//                                               .styleFrom(
//                                             backgroundColor:
//                                                 Color(0xFF3559E0),
//                                             shape:
//                                                 RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius
//                                                       .circular(
//                                                           8.0),
//                                             ),
//                                             side: BorderSide(
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           child: Text(
//                                             'Take Exam',
//                                             style: TextStyle(
//                                                 color:
//                                                     Colors.white),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                             height:
//                                                 20), // Adjust spacing between questions
//                                       ],
//                                     ),
//                                 ],
//                               ),
//                               decoration: BoxDecoration(
//                                 border: Border(
//                                   left: BorderSide(
//                                     color: Colors.green,
//                                     width: 5,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             clipper: ShapeBorderClipper(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius:
//                                     BorderRadius.circular(3),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         )
//       ],
//     ),
//   ),
//  );
// }

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
        borderRadius: BorderRadius.circular(40),
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
